using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class _Home : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["userID"] == null)
            Response.Redirect("Login.aspx");      
        
        string userID;
        userID = Session["userID"].ToString();

        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlCommand command = new SqlCommand("", sqlcon);
        if (Session["type"] != null && Session["type"].ToString().Equals("student"))
        {
            command.CommandText = "SELECT * FROM Posts_for_student WHERE userID = " + userID + " OR userID IN (SELECT followingID FROM followers WHERE followerID = " + userID + ") OR userID IN (SELECT id FROM Users WHERE username = 'admin' ) ORDER BY creation_time DESC";
        }
        else if (Session["type"] != null && Session["type"].ToString().Equals("teacher"))
            command.CommandText = "SELECT * FROM Posts_for_teachers WHERE userID = " + userID + " OR userID IN (SELECT followingID FROM followers WHERE followerID = " + userID + ") OR userID IN (SELECT id FROM Users WHERE username = 'admin' ) ORDER BY creation_time DESC";
        else
            command.CommandText = "SELECT * FROM Posts_for_student WHERE userID IN (SELECT id FROM Users WHERE username = \'admin\')";

        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            Posts.DataSource = reader;
            Posts.DataBind();
        }
        reader.Close();
        sqlcon.Close();
    }


    protected void Post_Click(object sender, EventArgs e)
    {
        string userID;
        if (!InputPost.Text.Equals(""))
        {
            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();

            userID = Session["userID"].ToString();
            SqlCommand command = new SqlCommand();
            command.Connection = sqlcon;
            command.CommandText = "CreatePost";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@user_id", SqlDbType.Int).Value = userID;
            command.Parameters.AddWithValue("@link", SqlDbType.VarChar).Value = "NA"; 
            command.Parameters.AddWithValue("@content", SqlDbType.VarChar).Value = InputPost.Text; 
            command.ExecuteNonQuery();
            sqlcon.Close();
            InputPost.Text = "";
            Page_Load(sender, e);
        }
    }
}