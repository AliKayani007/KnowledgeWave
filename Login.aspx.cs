using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Web.UI.HtmlControls;

public partial class _Login : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["displayname"] = "";
        Session["username"] = "";
        Session["userID"] = "";
        Session["DP_URL"] = "";
        Session["status"] = "";
        Session["type"] = "";
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        Incorrect.Text = "";
    }

    protected void Login_Click(object sender, EventArgs e)
    {
        SqlCommand command = new SqlCommand("SELECT * FROM Users WHERE username= \'"+Username.Text+"\' AND password= \'"+Password.Text+"\'", sqlcon);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.Read())
        {
            Session["userID"] = reader["id"].ToString();
            Session["username"] = Username.Text;
            //Session["displayname"] = reader["displayName"].ToString();
            //Session["DP_URL"] = reader["profilePic"].ToString();
            //Session["status"] = reader["status"].ToString();
            if (reader["type"].ToString().Equals("1"))
                Session["type"] = "admin";
            else if (reader["type"].ToString().Equals("2"))
                Session["type"] = "faculty";
            else if (reader["type"].ToString().Equals("3"))
                Session["type"] = "alumni";
            else if (reader["type"].ToString().Equals("4"))
                Session["type"] = "student";

            reader.Close();
            Response.Redirect("home.aspx");
        }
        else
        {
            Incorrect.Text = "Incorrect username and password.";
            Session["displayname"] = "";
            reader.Close();
        }

    }
}