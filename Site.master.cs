using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Site : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string id = "0";
        if (Session["userID"] != null)
        {
            id = Session["userID"].ToString();
        }
        
        if (Session["type"] == null || Session["userID"] == null)
            Response.Redirect("Login.aspx");    

        string path = HttpContext.Current.Request.Url.AbsolutePath;
        if (path.Equals("/home.aspx") || path.Equals("/Home.aspx"))
            PageSelectButton.Text = "HOME";
        else if (path.Equals("/discussion.aspx") || path.Equals("/Discussion.aspx"))
            PageSelectButton.Text = "DISCUSSION ROOM";
        else if (path.Equals("/profilepage.aspx") || path.Equals("/Profilepage.aspx"))
             PageSelectButton.Text = "PROFILE";
        else if (path.Equals("/Society.aspx") || path.Equals("/society.aspx"))
            PageSelectButton.Text = "SOCIETY";
        else if (path.Equals("/Catalogue.aspx") || path.Equals("/catalogue.aspx"))
            PageSelectButton.Text = "CATALOGUE";
        else if (path.Equals("/Search.aspx") || path.Equals("/search.aspx"))
            PageSelectButton.Text = "SEARCH";
        else if (path.Equals("/Dashboard.aspx") || path.Equals("/dashboard.aspx"))
            PageSelectButton.Text = "DASHBOARD";


        SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlCommand command = new SqlCommand("", sqlcon);    
        command.CommandText = "SELECT * FROM Users WHERE id = " + id;
        SqlDataReader reader = command.ExecuteReader();
        if (!reader.Read())
        {
            Response.Redirect("Login.aspx");
        }
        
        DisplayName.Text= reader["displayName"].ToString();
        if (Session["type"].ToString().Equals("admin"))
        {
            admin_dashboard.Visible = true;
            profile.Visible = false;
            DisplayName.Text = "Admin";
        }
        else
        {
            admin_dashboard.Visible = false;
            profile.NavigateUrl = "~/Profilepage.aspx?profile=" + Session["username"];
        }
        sqlcon.Close();
    }
    protected void SearchButton_Click(object sender, EventArgs e)
    {
        if (Search.Text == "")
            return;
        Session["SearchText"] = Search.Text;
        if (SelectAll.Checked)
            Session["filter"] = "all";
        else if (SelectStudent.Checked)
            Session["filter"] = "student";
        else if (SelectTeacher.Checked)
            Session["filter"] = "teacher";
        Response.Redirect("Search.aspx");
    }
    protected void ClickOnHome(object sender, EventArgs e)
    {
        Response.Redirect("Home.aspx");
    }
    protected void ClickOnDiscussion(object sender, EventArgs e)
    {
        Response.Redirect("Discussion.aspx");
    }
    protected void ClickOnSocieties(object sender, EventArgs e)
    {
        Response.Redirect("Society.aspx");
    }
    protected void ClickOnCatalogue(object sender, EventArgs e)
    {
        Response.Redirect("Catalogue.aspx");
    }

}
