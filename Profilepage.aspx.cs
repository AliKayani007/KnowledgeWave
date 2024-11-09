using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.NetworkInformation;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using static System.Net.WebRequestMethods;

public partial class ProfilePage : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
    string newName = "";
    //bool dpChange = false;
    //bool nameChange = false;
    //bool bioChange = false;
    string username;
    string userID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userID"] == null || Session["type"] == null)
            Response.Redirect("login.aspx");

        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
       
        OldName.Visible = true;
        NewName.Visible = false;
        OldBio.Visible = true;
        NewBio.Visible = false;
        userID = Session["userID"].ToString();
        username = HttpContext.Current.Request.Url.OriginalString;
        //if (username.Length == 39)
        //{ 
        //    Response.Redirect("Profilepage.aspx?profile=" + Session["username"].ToString());
        //}
        SqlCommand command = new SqlCommand("", sqlcon);
        username = username.Replace("http://localhost:49838/Profilepage.aspx?profile=", "");
        if (username == "http://localhost:49838/Profilepage.aspx")
        {
            username = Session["username"].ToString();
            Response.Redirect("Profilepage.aspx?profile=" + username);
        }
        else if (username == "admin")
        { 
            Response.Redirect("Home.aspx");
        }
            command.CommandText = "SELECT * FROM GetProfilesAll WHERE username = \'" + username + "\'";
        
        SqlDataReader reader = command.ExecuteReader();
        if (reader.Read())
        {
            if (!reader["profilePic"].ToString().Equals(""))
                DP.ImageUrl = reader["profilePic"].ToString();

            OldName.Text = reader["displayName"].ToString();
            OldBio.Text = reader["bio"].ToString();
            reader.Close();
        }
        else
        {
            Label1.Text = username;
            // did not get user, some kind of error
            reader.Close();
        }
        if (username != Session["username"].ToString())
        {
            EditBio.Visible = false;
            EditName.Visible = false;
            ProfilePic.Visible = false;
            Save_Changes.Visible = false;
            command.CommandText = "SELECT * FROM followers WHERE followerID = (SELECT id from users where username = \'" + Session["username"].ToString() + "\')" + "AND followingID = (SELECT id from users where username = \'" + username + "\')";
            SqlDataReader rdr = command.ExecuteReader();
            if (rdr.HasRows)
            {
                Follow.Visible = false;
                Following.Visible = true;
            }
            else
            {
                Follow.Visible = true;
                Following.Visible = false;
            }
        }
        else
        {
            EditBio.Visible = true;
            EditName.Visible = true;
            ProfilePic.Visible = true;
            Save_Changes.Visible = true;
            Follow.Visible = false;
            Following.Visible = false;
        }

        sqlcon.Close();
    }

    protected void Save_Changes_Click(object sender, EventArgs e)
    {
        int userID = Int32.Parse(Session["userID"].ToString());

        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlCommand command = new SqlCommand("", sqlcon);
        command.CommandType = CommandType.StoredProcedure;
        //command.Parameters.AddWithValue("@link", SqlDbType.VarChar).Value = //    file handling
        if (NewName.Text != "")
        {

            command.CommandText = "UpdateDisplayName";
            command.Parameters.AddWithValue("@name", SqlDbType.VarChar).Value = NewName.Text;
            command.Parameters.AddWithValue("@id", SqlDbType.Int).Value = userID;
            command.ExecuteNonQuery();
            command.Parameters.Clear();
        }
        if (NewBio.Text != "")
        {
            command.CommandText = "UpdateBio";
            if (Session["type"] != null && Session["type"].ToString().Equals("student"))
            {
                command.Parameters.AddWithValue("@type", SqlDbType.Int).Value = 4;
            }
            command.Parameters.AddWithValue("@id", SqlDbType.Int).Value = userID;
            command.Parameters.AddWithValue("@bio", SqlDbType.VarChar).Value = NewBio.Text;
            command.ExecuteNonQuery();
            command.Parameters.Clear();
        }
        if (ProfilePic.PostedFile != null)
        {
            string ext = Path.GetExtension(ProfilePic.FileName);
            if (ext != ".png" && ext != ".jpg" && ext != ".jpeg") ;
            else
            {
                string imgName = Path.GetFileName(ProfilePic.FileName);
                ProfilePic.SaveAs(Server.MapPath("~/ProfilePic/") + imgName);
                command.CommandText = "UpdateProfilePicture";
                command.Parameters.AddWithValue("@link", SqlDbType.VarChar).Value = "~/ProfilePic/" + imgName;
                command.Parameters.AddWithValue("@id", SqlDbType.Int).Value = userID;
                command.ExecuteNonQuery();
            }
        }



            sqlcon.Close();
        Response.Redirect("Profilepage.aspx?profile=" + username);
    }


    protected void EditName_Click(object sender, EventArgs e)
    {
        OldName.Visible = false;
        NewName.Visible = true;
    }

    protected void EditBio_Click(object sender, EventArgs e)
    {
        OldBio.Visible = false;
        NewBio.Visible = true;
    }

    protected void Follow_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        SqlCommand cmd = new SqlCommand("", sqlcon);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "NewFollower";
        cmd.Parameters.AddWithValue("@username1", SqlDbType.VarChar).Value = Session["username"].ToString();
        cmd.Parameters.AddWithValue("@username2", SqlDbType.VarChar).Value = username;
        cmd.ExecuteNonQuery();
        sqlcon.Close();
        Response.Redirect("Profilepage.aspx?profile=" + username);
    }

    protected void Following_Click(object sender, EventArgs e)
    {
        sqlcon.Open();
        SqlCommand cmd = new SqlCommand("", sqlcon);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "RemoveFollower";
        cmd.Parameters.AddWithValue("@username1", SqlDbType.VarChar).Value = Session["username"].ToString();
        cmd.Parameters.AddWithValue("@username2", SqlDbType.VarChar).Value = username;
        cmd.ExecuteNonQuery();
        sqlcon.Close();
        Response.Redirect("Profilepage.aspx?profile=" + username);
    }
}