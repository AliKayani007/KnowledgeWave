using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebPages;

public partial class _Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["type"] == null)
            Response.Redirect("Login.aspx");
        if (Session["type"].ToString() != "admin")
            Response.Redirect("Home.aspx");

        SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
        sqlcon.Open();
        string command = "Select Dname from department";
        SqlCommand cm= new SqlCommand(command, sqlcon);
        SqlDataReader rd = cm.ExecuteReader();
        _dept.DataSource = rd; 
        _dept.DataTextField = "Dname"; 
        _dept.DataValueField = "Dname"; 
        _dept.DataBind();
        rd.Close();
        rd = cm.ExecuteReader();
        _dept1.DataSource = rd;
        _dept1.DataTextField = "Dname";
        _dept1.DataValueField = "Dname";
        _dept1.DataBind();
        rd.Close();
        command = "Select type_name FROM types_teachers";
        cm.CommandText = command;
        rd = cm.ExecuteReader();
        _TeacherType.DataBind();
        _TeacherType.DataSource = rd;
        _TeacherType.DataTextField = "type_name";
        _TeacherType.DataValueField = "type_name";
        _TeacherType.DataBind();
        sqlcon.Close();
        rd.Close();
    }

    protected void AddStudent_Click(object sender, EventArgs e)
    {
        if (_username.Text == "" || _displayname.Text == "" || _password.Text == "" || _firstname.Text == "" || _lastname.Text == ""
            || (!_gender_male.Checked && !_gender_female.Checked) || _dob.Text == "" || _dept.SelectedValue == "" || _Batch.Text == "" || _Email.Text == "" || _Contact.Text == "" || _Address.Text == "") 
        {
            Invalid.Text = "Cannot Add New Student ! Please fill all fields...";
            return;
        }
        SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
        sqlcon.Open();
        string command = "Select * from Users where username = \'" + _username.Text + "\'";
        SqlCommand cm= new SqlCommand(command, sqlcon);
        SqlDataReader rd = cm.ExecuteReader();
        if (rd.HasRows)
        {
            Invalid.Text = "This Username already exists.";
            return;
        }
        rd.Close();
        command = "Select * from Students where email = \'"+_Email.Text + "\'";
        cm.CommandText = command;
        rd = cm.ExecuteReader();
        if (rd.HasRows)
        {
            Invalid.Text = "Email already in use.";
            return;
        }
        rd.Close();

        command = "Select dno from Department where dname = \'" + _dept.Text + "\'";
        cm.CommandText = command;
        string dno = cm.ExecuteScalar().ToString();
    
        command = "AddStudents";
        cm.CommandText = command;
        cm.CommandType = System.Data.CommandType.StoredProcedure;
        cm.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = _username.Text;
        cm.Parameters.AddWithValue("@password", SqlDbType.VarChar).Value = _password.Text;
        cm.Parameters.AddWithValue("@displayname", SqlDbType.VarChar).Value = _displayname.Text;
        cm.Parameters.AddWithValue("@fname", SqlDbType.VarChar).Value = _firstname.Text;
        cm.Parameters.AddWithValue("@lname", SqlDbType.VarChar).Value = _lastname.Text;
        
        if (_gender_male.Checked)
            cm.Parameters.AddWithValue("@gender", SqlDbType.VarChar).Value = "M";
        else if (_gender_female.Checked)
            cm.Parameters.AddWithValue("@gender", SqlDbType.VarChar).Value = "F";

        cm.Parameters.AddWithValue("@dob", SqlDbType.Date).Value = _dob.Text;
        cm.Parameters.AddWithValue("@dept", SqlDbType.Int).Value = dno.AsInt();
        cm.Parameters.AddWithValue("@batch", SqlDbType.Int).Value = _Batch.Text.AsInt();
        cm.Parameters.AddWithValue("@email", SqlDbType.VarChar).Value = _Email.Text;
        cm.Parameters.AddWithValue("@contact", SqlDbType.VarChar).Value = _Contact.Text;
        cm.Parameters.AddWithValue("@address", SqlDbType.VarChar).Value = _Address.Text;

        cm.ExecuteNonQuery();
        sqlcon.Close();

        _username.Text = "";
        _password.Text = "";
        _displayname.Text = "";
        _firstname.Text = "";
        _lastname.Text = "";
        _gender_male.Checked = false;
        _gender_female.Checked = false;
        _dob.Text = "";
        _Batch.Text = "";
        _Email.Text = "";
        _Contact.Text = "";
        _Address.Text = "";
        Valid.Text = "Student Added";
    }

    protected void AddTeacher_Click(object sender, EventArgs e)
    {
        if (_username1.Text == "" || _displayname1.Text == "" || _password1.Text == "" || _firstname1.Text == "" || _lastname1.Text == ""
            || (!_gender_male1.Checked && !_gender_female1.Checked) || _dob1.Text == "" || _dept1.SelectedValue == "" || _JoinDate1.Text == "" || _Email1.Text == "" || _Contact1.Text == "" || _Address1.Text == "")
        {
            Invalid1.Text = "Cannot Add New Teacher! Please fill all fields...";
            return;
        }
        SqlConnection sqlcon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=\"D:\\My Projects\\Gryphin\\App_Data\\Gryphon.mdf\";Integrated Security=True");
        sqlcon.Open();
        string command = "Select * from Users where username = \'" + _username1.Text + "\'";
        SqlCommand cm = new SqlCommand(command, sqlcon);
        SqlDataReader rd = cm.ExecuteReader();
        if (rd.HasRows)
        {
            Invalid1.Text = "This Username already exists.";
            return;
        }
        rd.Close();
        command = "Select * from Teachers where email = \'" + _Email1.Text + "\'";
        cm.CommandText = command;
        rd = cm.ExecuteReader();
        if (rd.HasRows)
        {
            Invalid1.Text = "Email already in use.";
            return;
        }
        rd.Close();

        command = "Select dno from Department where dname = \'" + _dept1.Text + "\'";
        cm.CommandText = command;
        string dno = cm.ExecuteScalar().ToString();
        command = "Select id from types_teachers where type_name = \'" + _TeacherType.Text + "\'";
        cm.CommandText = command;
        string type = cm.ExecuteScalar().ToString();



        command = "AddTeacher";
        cm.CommandText = command;
        cm.CommandType = System.Data.CommandType.StoredProcedure;
        cm.Parameters.AddWithValue("@username", SqlDbType.VarChar).Value = _username1.Text;
        cm.Parameters.AddWithValue("@password", SqlDbType.VarChar).Value = _password1.Text;
        cm.Parameters.AddWithValue("@displayname", SqlDbType.VarChar).Value = _displayname1.Text;
        cm.Parameters.AddWithValue("@fname", SqlDbType.VarChar).Value = _firstname1.Text;
        cm.Parameters.AddWithValue("@lname", SqlDbType.VarChar).Value = _lastname1.Text;

        if (_gender_male1.Checked)
            cm.Parameters.AddWithValue("@gender", SqlDbType.VarChar).Value = "M";
        else if (_gender_female1.Checked)
            cm.Parameters.AddWithValue("@gender", SqlDbType.VarChar).Value = "F";

        cm.Parameters.AddWithValue("@dob", SqlDbType.Date).Value = _dob1.Text;
        cm.Parameters.AddWithValue("@dept", SqlDbType.Int).Value = dno.AsInt();
        cm.Parameters.AddWithValue("@join", SqlDbType.Date).Value = _JoinDate1.Text;
        cm.Parameters.AddWithValue("@email", SqlDbType.VarChar).Value = _Email.Text;
        cm.Parameters.AddWithValue("@contact", SqlDbType.VarChar).Value = _Contact.Text;
        cm.Parameters.AddWithValue("@address", SqlDbType.VarChar).Value = _Address.Text;
        cm.Parameters.AddWithValue("@type", SqlDbType.Int).Value = type;

        cm.ExecuteNonQuery();
        sqlcon.Close();

        _username1.Text = "";
        _password1.Text = "";
        _displayname1.Text = "";
        _firstname1.Text = "";
        _lastname1.Text = "";
        _gender_male1.Checked = false;
        _gender_female1.Checked = false;
        _dob1.Text = "";
        _JoinDate1.Text = "";
        _Email1.Text = "";
        _Contact1.Text = "";
        _Address1.Text = "";
        Valid1.Text = "Teacher Added";
    }
}