using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Catalogue : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {

        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlCommand command = new SqlCommand("", sqlcon);
        command.CommandText = "SELECT * FROM GetCoursesAndPreReq ";
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            Courses_list.DataSource = reader;
            Courses_list.DataBind();
        }
        reader.Close();
        command.CommandText = "SELECT * FROM viewTeacher";
        SqlDataReader reader2 = command.ExecuteReader();
        if (reader2.HasRows)
        {
            Teacher_list.DataSource = reader2;
            Teacher_list.DataBind();
        }
        reader2.Close();
        sqlcon.Close();
    }
}