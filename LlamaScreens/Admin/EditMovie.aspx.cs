using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LlamaScreens.Admin
{
    public partial class EditMovie : System.Web.UI.Page
    {
        List<int> categoryIds = new List<int>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["movie_id"] == null || Session["movie_id"].ToString() == "")
            {
                Response.Redirect("Movie.aspx");
            }

            string movieId = Session["movie_id"].ToString();

            SqlDataSource3.SelectCommand = "SELECT * FROM Movie WHERE movie_id = " + movieId;
            SqlDataSource3.DataBind();

            if (!IsPostBack)
            {
                DataView dataView = (DataView)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
                foreach (DataRowView rowView in dataView)
                {
                    lblPictureInput.Style["background-image"] = "url('../Img/Movies/" + rowView["movie_id"].ToString() + "/picture.jpg')";
                    lblBigPictureInput.Style["background-image"] = "url('../Img/Movies/" + rowView["movie_id"].ToString() + "/banner.jpg')";
                    movieTrailer.Attributes["src"] = "../Img/Movies/" + rowView["movie_id"].ToString() + "/trailer.mp4";
                    titleInput.Text = rowView["movie_title"].ToString();
                    descriptionInput.Text = rowView["movie_description"].ToString();
                    directorInput.Text = rowView["movie_director"].ToString();
                    companyInput.Text = rowView["movie_company"].ToString();
                    actorInput.Text = rowView["movie_actor"].ToString();
                    lengthInput.Text = rowView["movie_length"].ToString();
                    if (DateTime.TryParse(rowView["release_date"].ToString(), out DateTime dateRelease))
                    {
                        date.Text = dateRelease.ToString("yyyy-MM-dd"); ;
                    }
                    countryInput.Text = rowView["movie_country"].ToString();
                }


                categoryIds.Add(-1);
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "SELECT * FROM MovieCategoryBridge WHERE movie_id = @movieId";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@movieId", movieId);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            categoryIds.Add(Convert.ToInt32(reader["category_id"]));
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
                ViewState["categoryIds"] = categoryIds;
            }
            categoryIds = (List<int>)ViewState["categoryIds"];
            updateCategory();

        }
        protected void Form_Submission(object sender, EventArgs e)
        {
            bool isFormValid = true;
            bool noPictureChange = false;
            bool noBannerChange = false;
            bool noTrailerChange = false;

            HttpPostedFile picture = pictureInput.PostedFile;
            HttpPostedFile banner = bigpictureInput.PostedFile;
            HttpPostedFile trailer = trailerInput.PostedFile;

            string title = titleInput.Text.Trim();
            string description = descriptionInput.Text.Trim();
            string directors = directorInput.Text.Trim();
            string company = companyInput.Text.Trim();
            string country = countryInput.Text.Trim();
            string actors = actorInput.Text.Trim();
            string lengthstr = lengthInput.Text.Trim();
            string datestr = date.Text.Trim();

            string[] categories = new string[categoryIds.Count];
            for (int i = 0; i < categoryIds.Count; i++)
            {
                categories[i] = categoryIds[i].ToString();
            }

            if (picture == null || picture.ContentLength == 0)
            {
                noPictureChange = true;
            }

            if (banner == null || banner.ContentLength == 0)
            {
                noBannerChange = true;
            }

            if (trailer == null || trailer.ContentLength == 0)
            {
                noTrailerChange = true;
            }

            if (title == "" || title == null)
            {
                isFormValid = false;
            }
            else
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        //get id
                        string id = Session["movie_id"].ToString();
                        //check if title exist in other movies
                        string query = "SELECT * FROM Movie WHERE movie_title = @title AND movie_id != @id";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@title", title);
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            isFormValid = false;
                            ErrMsg.Text = "Movie title already exists";
                        }
                        conn.Close();
                    }
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = "Movie title already exists";
                }
            }

            if (description == "" || description == null)
            {
                isFormValid = false;
            }

            if (directors == "" || directors == null)
            {
                isFormValid = false;
            }

            if (company == "" || company == null)
            {
                isFormValid = false;
            }

            if (country == "" || country == null)
            {
                isFormValid = false;
            }

            if (actors == "" || actors == null)
            {
                isFormValid = false;
            }

            int length = 0;
            if (int.TryParse(lengthstr, out int lengthResult))
            {
                length = lengthResult;
            }
            else
            {
                if (isFormValid)
                {
                    isFormValid = false;
                    ErrMsg.Text = "Invalid Movie Length";
                }
            }

            if (length < 1)
            {
                if (isFormValid)
                {
                    isFormValid = false;
                    ErrMsg.Text = "Movie Length Must More than or Equal to 10 Min ";
                }

            }

            DateTime releaseDate = DateTime.Now;
            if (DateTime.TryParse(datestr, out DateTime dateResult))
            {
                releaseDate = dateResult;
            }
            else
            {
                if (isFormValid)
                {
                    isFormValid = false;
                    ErrMsg.Text = "Invalid Date";
                }
            }

            if (isFormValid)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        int movieId = Convert.ToInt32(Session["movie_id"].ToString());
                        string query = "UPDATE Movie SET movie_title = @title, movie_description = @description, movie_length = @length, movie_director = @director, movie_actor = @actor, movie_country = @country, movie_company = @company, release_date = @release WHERE movie_id = @movieId;SELECT SCOPE_IDENTITY();";
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@movieId", movieId);
                        cmd.Parameters.AddWithValue("@title", title);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@length", length);
                        cmd.Parameters.AddWithValue("@director", directors);
                        cmd.Parameters.AddWithValue("@actor", actors);
                        cmd.Parameters.AddWithValue("@country", country);
                        cmd.Parameters.AddWithValue("@company", company);
                        cmd.Parameters.AddWithValue("@release", releaseDate);
                        ErrMsg.Text = title;
                        string movieID = cmd.ExecuteScalar().ToString();
                        conn.Close();


                        //insert into log
                        LogController log = new LogController(Session["adminID"].ToString(), "Updated Movie #" + movieId);
                        log.createLog();

                        //insert categories
                        foreach (string category in categories)
                        {
                            if (category != "-1")
                            {
                                bool existCat = false;
                                //check if category already exists
                                query = "SELECT * FROM MovieCategoryBridge WHERE movie_id = @movieId AND category_id = @categoryId";
                                conn.Open();
                                cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@movieId", movieId);
                                cmd.Parameters.AddWithValue("@categoryId", Convert.ToInt16(category));
                                ErrMsg.Text = "2";
                                SqlDataReader reader = cmd.ExecuteReader();
                                if (reader.HasRows)
                                {
                                    existCat = true;
                                }
                                conn.Close();
                                //insert
                                if (!existCat)
                                {
                                    query = "INSERT INTO MovieCategoryBridge (movie_id, category_id) VALUES (@movieId, @categoryId)";
                                    conn.Open();
                                    cmd = new SqlCommand(query, conn);
                                    cmd.Parameters.AddWithValue("@movieId", movieId);
                                    cmd.Parameters.AddWithValue("@categoryId", Convert.ToInt16(category));
                                    cmd.ExecuteNonQuery();
                                    conn.Close();
                                }
                                
                            }
                        }


                        //delete categories that are not in the list
                        query = "DELETE FROM MovieCategoryBridge WHERE movie_id = @movieId";
                        if(categories.Length > 1)
                        {
                            query += " AND category_id NOT IN (";
                            foreach (string category in categories)
                            {
                                if (category != "-1")
                                {
                                    query += category + ",";
                                }
                            }
                            query = query.Remove(query.Length - 1);
                            query += ")";
                        }
                        
                        conn.Open();
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@movieId", movieId);
                        ErrMsg.Text = "3";
                        cmd.ExecuteNonQuery();
                        conn.Close();


                        if (!noPictureChange || !noBannerChange || !noTrailerChange)
                        {
                            string folderPath = Server.MapPath($"~/Img/Movies/{movieId}/");// Save the uploaded file to the server
                            Directory.CreateDirectory(folderPath);// Create the folder if it doesn't exist
                            if (!noPictureChange)
                            {
                                string extension = Path.GetExtension(picture.FileName);
                                string uploadedFileName = $"uploadedPicture{extension}";
                                string uploadedFilePath = Path.Combine(folderPath, uploadedFileName);
                                string originalFilePath = $"{folderPath}uploadedPicture{extension}";
                                picture.SaveAs(originalFilePath);
                                string convertedFileName = $"picture.jpg";
                                string convertedFilePath = Path.Combine(folderPath, convertedFileName);
                                using (System.Drawing.Image img = System.Drawing.Image.FromFile(originalFilePath))
                                {
                                    img.Save(convertedFilePath, System.Drawing.Imaging.ImageFormat.Jpeg);
                                }
                            }

                            if (!noBannerChange)
                            {
                                string extension = Path.GetExtension(banner.FileName);
                                string uploadedFileName = $"uploadedBanner{extension}";
                                string uploadedFilePath = Path.Combine(folderPath, uploadedFileName);
                                string originalFilePath = $"{folderPath}uploadedBanner{extension}";
                                banner.SaveAs(originalFilePath);
                                string convertedFileName = $"banner.jpg";
                                string convertedFilePath = Path.Combine(folderPath, convertedFileName);
                                using (System.Drawing.Image img = System.Drawing.Image.FromFile(originalFilePath))
                                {
                                    img.Save(convertedFilePath, System.Drawing.Imaging.ImageFormat.Jpeg);
                                }
                            }

                            if (!noTrailerChange)
                            {
                                //trailer
                                string extension = Path.GetExtension(trailer.FileName);
                                string filePath = $"{folderPath}trailer{extension}";
                                trailer.SaveAs(filePath);
                            }


                            string[] files = Directory.GetFiles(folderPath);
                            foreach (string file in files)
                            {
                                string fileName = Path.GetFileName(file);
                                if (fileName != "picture.jpg" && fileName != "banner.jpg" && fileName != "trailer.mp4")
                                {
                                    File.Delete(file);
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    //ErrMsg.Text = ex.Source;
                }
            }


        }



        protected void Repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView rowView = (DataRowView)e.Item.DataItem;
                string categoryId = rowView["category_id"].ToString();
                string categoryName = rowView["category_name"].ToString();

                Button dynamicButton = (Button)e.Item.FindControl("btn");

                dynamicButton.CommandArgument = categoryId;
                dynamicButton.Text = categoryName;

                AsyncPostBackTrigger trigger = new AsyncPostBackTrigger();
                trigger.ControlID = dynamicButton.UniqueID;
                trigger.EventName = "Click";
                UpdatePanel1.Triggers.Add(trigger);
            }
        }

        protected void updateCategory()
        {
            string query = "Select * From [Category] Where category_id IN (";
            foreach (int id in categoryIds)
            {
                query += id + ",";
            }
            query = query.Remove(query.Length - 1);
            query += ");";
            SqlDataSource1.SelectCommand = query;
            SqlDataSource1.DataBind();

            search();
        }


        protected void Category_Btn_Pressed(object sender, CommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            categoryIds.Add(id);
            ViewState["categoryIds"] = categoryIds;
            updateCategory();
        }

        protected void Category_Btn_Pressed_Reverse(object sender, CommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument.ToString());
            categoryIds.Remove(id);
            ViewState["categoryIds"] = categoryIds;
            updateCategory();
        }


        protected void search_trigger(object sender, EventArgs e)
        {
            search();
        }

        protected void search()
        {
            string keyword = "%" + search_textbox.Text.Trim() + "%";

            string query = "Select * From [Category] Where CATEGORY_NAME LIKE @id AND category_id NOT IN (";
            foreach (int id in categoryIds)
            {
                query += id + ",";
            }
            query = query.Remove(query.Length - 1);
            query += ");";


            SqlDataSource2.SelectParameters.Clear();
            SqlDataSource2.SelectCommand = query;
            SqlDataSource2.SelectParameters.Add("id", keyword);
            SqlDataSource2.DataBind();
        }

        protected void addCategory(object sender, EventArgs e)
        {
            string newCategory = categoryInput.Text.Trim();
            categoryInput.Text = "";
            if (newCategory != "")
            {
                bool exist = false;
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "SELECT CATEGORY_ID FROM CATEGORY WHERE CATEGORY_NAME LIKE @new";
                        conn.Open();
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@new", newCategory);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            exist = true;
                        }
                        conn.Close();

                        if (!exist)
                        {
                            query = "INSERT INTO Category (category_name,created_date) VALUES (@name,@date);SELECT SCOPE_IDENTITY();";
                            cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@name", newCategory);
                            cmd.Parameters.AddWithValue("@date", DateTime.Now);
                            conn.Open();
                            object categoryID = cmd.ExecuteScalar();
                            conn.Close();

                            LogController log = new LogController(Session["adminID"].ToString(), "Created New Category #" + categoryID.ToString());
                            log.createLog();

                            search();
                        }
                        else
                        {
                            ErrMsg.Text = "Category already Exist";
                        }
                    }
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = "Failed To Connect Database";
                }
            }
        }
    }
}