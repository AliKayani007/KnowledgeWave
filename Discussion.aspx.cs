using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Discussion : System.Web.UI.Page
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
        command.CommandText = "SELECT TOP 50 * FROM DiscussionPosts ORDER BY creation_time DESC";
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            disPosts.DataSource = reader;
            disPosts.DataBind();
        }
        reader.Close();
        sqlcon.Close();

    }

    protected void disPost_Click(object sender, EventArgs e)
    {
        string userID;
        if (!InputPost.Text.Equals(""))
        {
            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();

            userID = Session["userID"].ToString();
            SqlCommand command = new SqlCommand();
            command.Connection = sqlcon;
            command.CommandText = "CreateDiscussion";
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@user_id", SqlDbType.Int).Value = userID;
            command.Parameters.AddWithValue("@link", SqlDbType.VarChar).Value = "NA";
            command.Parameters.AddWithValue("@content", SqlDbType.VarChar).Value = InputPost.Text;
            command.ExecuteNonQuery();
            sqlcon.Close();
            Page_Load(sender, e);
        }
    }
}
