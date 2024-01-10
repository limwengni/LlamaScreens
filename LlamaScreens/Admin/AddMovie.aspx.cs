using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace LlamaScreens.Admin
{
    public partial class AddMovie : System.Web.UI.Page
    {
        protected List<int> categoryIds = new List<int>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                categoryIds.Add(-1);
                ViewState["categoryIds"] = categoryIds;
            }
            categoryIds = (List<int>)ViewState["categoryIds"];
            updateCategory();
        }

        protected void Form_Submission(object sender, EventArgs e)
        {
            bool isFormValid = true;
            bool isFormFilled = true;
            HttpPostedFile picture = pictureInput.PostedFile;
            HttpPostedFile banner = bigpictureInput.PostedFile;
            HttpPostedFile trailer = trailerInput.PostedFile;

            string title = titleInput.Text.Trim();
            string description = descriptionInput.Text.Trim();
            string directors = directorInput.Text.Trim();
            string company = companyInput.Text.Trim();
            string country = countryInput.Text.Trim();
            string actors = actorInput.Text.Trim();
            string pricestr = priceInput.Text.Trim();
            string lengthstr = lengthInput.Text.Trim();
            string datestr = date.Text.Trim();

            string[] categories = new string[categoryIds.Count];
            for (int i = 0; i < categoryIds.Count; i++)
            {
                categories[i] = categoryIds[i].ToString();
            }
            ErrMsg.Text = "";
            //validations
            if (picture == null || picture.ContentLength == 0)
            {
                isFormFilled = false;
            }

            if (banner == null || picture.ContentLength == 0)
            {
                isFormFilled = false;
            }

            if (trailer == null || picture.ContentLength == 0)
            {
                isFormFilled = false;
            }

            if (title == "" || title == null)
            {
                isFormFilled = false;
            }else{
                //check no duplicate titles
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "SELECT movie_title FROM Movie WHERE movie_title = @title";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@title", title);
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
                    ErrMsg.Text = "Fail To Connect DB";
                }
            }

            if (description == "" || description == null)
            {
                isFormFilled = false;
            }

            if (directors == "" || directors == null)
            {
                isFormFilled = false;
            }

            if (company == "" || company == null)
            {
                isFormFilled = false;
            }

            if (country == "" || country == null)
            {
                isFormFilled = false;
            }

            if (actors == "" || actors == null)
            {
                isFormFilled = false;
            }

            if (pricestr == "")
            {
                isFormFilled = false;
            }

            if (lengthstr == "")
            {
                isFormFilled = false;
            }

            if (datestr == "")
            {
                isFormFilled = false;
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

            double price = 0;
            if (double.TryParse(pricestr, out double priceResult))
            {
                price = priceResult;
            }
            else
            {
                if (isFormValid)
                {
                    isFormValid = false;
                    ErrMsg.Text = "Invalid Price";
                }
                
            }

            if (price < 1)
            {
                if (isFormValid)
                {
                    isFormValid = false;
                    ErrMsg.Text = "Price Must More than or Equal to 1 ";
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

            if (isFormValid && isFormFilled)
            {
                try
                {
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Llamadb"].ConnectionString))
                    {
                        string query = "INSERT INTO Movie (movie_title, movie_description, movie_length, movie_director, movie_actor, movie_country, movie_company, default_price, release_date, created_date, status)"
                                       + " VALUES (@title, @description, @length, @director, @actor, @country, @company, @price, @release, @created, @status)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@title", title);
                        cmd.Parameters.AddWithValue("@description", description);
                        cmd.Parameters.AddWithValue("@length", length);
                        cmd.Parameters.AddWithValue("@director", directors);
                        cmd.Parameters.AddWithValue("@actor", actors);
                        cmd.Parameters.AddWithValue("@country", country);
                        cmd.Parameters.AddWithValue("@company", company);
                        cmd.Parameters.AddWithValue("@price", price);
                        cmd.Parameters.AddWithValue("@release", releaseDate);
                        cmd.Parameters.AddWithValue("@created", DateTime.Now);
                        cmd.Parameters.AddWithValue("@status", "Coming Soon");
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        //get id
                        query = "SELECT movie_id FROM Movie WHERE movie_title = @title";
                        cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@title", title);
                        int movieId = Convert.ToInt32(cmd.ExecuteScalar());
                        if(movieId == 0)
                        {
                            return;
                        }
                        LogController log = new LogController(Session["adminID"].ToString(), "Created New Movie #" + movieId.ToString());
                        log.createLog();

                        //insert categories
                        foreach (string category in categories)
                        {
                            if(category != "-1")
                            {
                                query = "INSERT INTO MovieCategoryBridge (movie_id, category_id) VALUES (@movieId, @categoryId)";
                                cmd = new SqlCommand(query, conn);
                                cmd.Parameters.AddWithValue("@movieId", movieId);
                                cmd.Parameters.AddWithValue("@categoryId", Convert.ToInt16(category));
                                cmd.ExecuteNonQuery();
                            }
                        }

                        string folderPath = Server.MapPath($"~/Img/Movies/{movieId}/");// Save the uploaded file to the server
                        Directory.CreateDirectory(folderPath);// Create the folder if it doesn't exist

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

                        extension = Path.GetExtension(banner.FileName);
                        uploadedFileName = $"uploadedBanner{extension}";
                        uploadedFilePath = Path.Combine(folderPath, uploadedFileName);
                        originalFilePath = $"{folderPath}uploadedBanner{extension}";
                        banner.SaveAs(originalFilePath);
                        convertedFileName = $"banner.jpg";
                        convertedFilePath = Path.Combine(folderPath, convertedFileName);
                        using (System.Drawing.Image img = System.Drawing.Image.FromFile(originalFilePath))
                        {
                            img.Save(convertedFilePath, System.Drawing.Imaging.ImageFormat.Jpeg);
                        }

                        //trailer
                        extension = Path.GetExtension(trailer.FileName);
                        string filePath = $"{folderPath}trailer{extension}";
                        trailer.SaveAs(filePath);

                        //remove all files that name arent picture, banner and trailer
                        string[] files = Directory.GetFiles(folderPath);
                        foreach (string file in files)
                        {
                            string fileName = Path.GetFileName(file);
                            if (fileName != "picture.jpg" && fileName != "banner.jpg" && fileName != "trailer.mp4")
                            {
                                File.Delete(file);
                            }
                        }

                        conn.Close();
                        Response.Redirect("~/Admin/Movie.aspx");
                    }
                }
                catch (Exception ex)
                {
                    ErrMsg.Text = "Failed to add movie";
                }
            }
            else
            {
                if(!isFormFilled)
                {
                    ErrMsg.Text = "Please Fill All the Fields";
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