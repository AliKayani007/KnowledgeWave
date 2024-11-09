using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Search : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True; MultipleActiveResultSets=True");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SearchText"] == null || Session["filter"] == null)
            Response.Redirect("Login.aspx");

        string txt = Session["SearchText"].ToString();
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlCommand command = new SqlCommand("", sqlcon);

        if (Session["filter"].ToString().Equals("all"))
            command.CommandText = "SELECT username, profilePic, displayName  FROM Users WHERE username LIKE \'" + txt + "%\' OR displayName LIKE \'" + txt + "%\'";
        else if (Session["filter"].ToString().Equals("student"))
            command.CommandText = "SELECT username, profilePic, displayName  FROM Users u JOIN Students s ON u.id = s.userID WHERE username LIKE \'" + txt + "%\' OR displayName LIKE \'" + txt + "%\'";
        else if (Session["filter"].ToString().Equals("teacher"))
            command.CommandText = "SELECT username, profilePic, displayName  FROM Users u JOIN Teachers t ON u.id = t.userID WHERE username LIKE \'" + txt + "%\' OR displayName LIKE \'" + txt + "%\'";

        SqlDataReader rdr = command.ExecuteReader();
        if (rdr.HasRows)
        {
            Search_results.DataSource = rdr;
            Search_results.DataBind();
        }
        rdr.Close();
        sqlcon.Close();
    }

    protected void Search_results_ItemCommand(object source, DataListCommandEventArgs e)
    {
    }


    protected void Profile_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        Response.Redirect("Profilepage.aspx?profile=" + btn.CommandArgument);
    }
}