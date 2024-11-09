using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Society : System.Web.UI.Page
{
    SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
    protected void Page_Load(object sender, EventArgs e)
    {
    
        if (sqlcon.State == ConnectionState.Closed)
            sqlcon.Open();
        SqlCommand command = new SqlCommand("", sqlcon);
        command.CommandText = "SELECT * FROM societies";
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {
            Societies_list.DataSource = reader;
            Societies_list.DataBind();
        }
        reader.Close();
        sqlcon.Close();
    }
}