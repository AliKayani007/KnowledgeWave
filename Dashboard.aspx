<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .dashboard_content {
            position: absolute;
            top: 7.5vh;
            left: 2.5vh;
            padding-bottom: 50px;
        }
         .headerTag{
            position: relative;
            color: #009B9C ;
            left: 90vh;
            padding-top: 20px;
            padding-bottom: 20px;
            font-weight: 800;
        }
        .AddStudent {
            position: relative;
            background-color: #009B9C;
            width: 100vh;
            height: 950px;
            color: white;
            font-size: 20px;
            font-weight: 400;
            left: 50vh;
            padding-top: 20px;
            padding-left: 15%;
            padding-right: 15%;
            border: 3px solid black;
            border-radius: 20px 20px;
        }
        .AddTeacher {
            position: relative;
            background-color: #009B9C;
            width: 100vh;
            height: 1000px;
            color: white;
            font-size: 20px;
            font-weight: 400;
            left: 50vh;
            padding-top: 20px;
            padding-left: 15%;
            padding-right: 15%;
            border: 3px solid black;
            border-radius: 20px 20px;
        }
        .error-message {
	    	color: #E74C3C;
	    	font-size: 1em;
	    	margin-top: 10px;
        }
        .confirm-message {
	    	color: lawngreen;
	    	font-size: 1em;
	    	margin-top: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="dashboard_content">
        <div>
            <h1 class="headerTag">Add Student</h1>
        </div>
        <div class="AddStudent">
            <asp:Label ID="Invalid" runat="server" Text="" CssClass="error-message"></asp:Label>
            <asp:Label ID="Valid" runat="server" Text="" CssClass="confirm-message"></asp:Label>
            <br />
            <br />
            <asp:Label ID="username" runat="server" Text="UserName: "></asp:Label>
            <asp:TextBox ID="_username"  runat="server"  Width="380" style="margin-left:54px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="displayname" runat="server" Text="DisplayName: "></asp:Label>
            <asp:TextBox ID="_displayname" runat="server" Width="380" style="margin-left:30px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="password" runat="server" Text="Password: "></asp:Label>
            <asp:TextBox ID="_password" runat="server" Width="380"  style="margin-left:64px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="firstname" runat="server" Text="First Name: "></asp:Label>
            <asp:TextBox ID="_firstname" runat="server" Width="380"  style="margin-left:52px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lastname" runat="server" Text="Last Name: "></asp:Label>
            <asp:TextBox ID="_lastname" runat="server" Width="380"  style="margin-left:54px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="gender" runat="server" Text="Gender: "></asp:Label>
            <asp:RadioButton ID="_gender_male" GroupName="Gender" runat="server" style="margin-left:90px;"/>
              <asp:Label ID="male" runat="server" Text="Male" style="margin-left:20px;" Font-Bold="true"></asp:Label>
            <asp:RadioButton ID="_gender_female" GroupName="Gender" runat="server" style="margin-left:25%;"/>
              <asp:Label ID="female" runat="server" Text="Female" style="margin-left:20px;" Font-Bold="true"></asp:Label>
            <br /><br />
            <asp:Label ID="dob" runat="server" Text="Date of Birth: "></asp:Label>
            <asp:TextBox ID="_dob" TextMode="Date" runat="server" Width="380"  style="margin-left:34px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Dept" runat="server" Text="Department:" ></asp:Label>
            <asp:DropDownList ID="_dept" runat="server" Width="380" style="margin-left:40px" >
            </asp:DropDownList>
            <br /><br />
            <asp:Label ID="Batch" runat="server" Text="Batch: "></asp:Label>
            <asp:TextBox ID="_Batch" TextMode="Number" runat="server" Width="380"  style="margin-left:97px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Email" runat="server" Text="Email: "></asp:Label>
            <asp:TextBox ID="_Email" TextMode="Email" runat="server" Width="380"  style="margin-left:99px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Contact" runat="server" Text="Contact no: "></asp:Label>
            <asp:TextBox ID="_Contact" TextMode="Phone" runat="server" Width="380"  style="margin-left:49px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Address" runat="server" Text="Address: "></asp:Label>
            <asp:TextBox ID="_Address" runat="server" Width="380"  style="margin-left:74px"></asp:TextBox>
            <br /><br />
            <asp:Button ID="AddStudent" runat="server" Text="Add" style="margin-left: 100%; padding-left: 30px; padding-right: 30px;" OnClick="AddStudent_Click" />
        </div>
        <%--------------------------------------------------------------------------------------------------%>
        <div>
            <h1 class="headerTag">Add Teacher</h1>
        </div>
        <div class="AddTeacher">
            <asp:Label ID="Invalid1" runat="server" Text="" CssClass="error-message"></asp:Label>
            <asp:Label ID="Valid1" runat="server" Text="" CssClass="confirm-message"></asp:Label>
            <br />
            <br />
            <asp:Label ID="username1" runat="server" Text="UserName: "></asp:Label>
            <asp:TextBox ID="_username1"  runat="server"  Width="380" style="margin-left:54px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="displayname1" runat="server" Text="DisplayName: "></asp:Label>
            <asp:TextBox ID="_displayname1" runat="server" Width="380" style="margin-left:30px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="password1" runat="server" Text="Password: "></asp:Label>
            <asp:TextBox ID="_password1" runat="server" Width="380"  style="margin-left:64px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="firstname1" runat="server" Text="First Name: "></asp:Label>
            <asp:TextBox ID="_firstname1" runat="server" Width="380"  style="margin-left:52px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="lastname1" runat="server" Text="Last Name: "></asp:Label>
            <asp:TextBox ID="_lastname1" runat="server" Width="380"  style="margin-left:54px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="gender1" runat="server" Text="Gender: "></asp:Label>
            <asp:RadioButton ID="_gender_male1" GroupName="Gender1" runat="server" style="margin-left:90px;"/>
              <asp:Label ID="male1" runat="server" Text="Male" style="margin-left:20px;" Font-Bold="true"></asp:Label>
            <asp:RadioButton ID="_gender_female1" GroupName="Gender1" runat="server" style="margin-left:25%;"/>
              <asp:Label ID="female1" runat="server" Text="Female" style="margin-left:20px;" Font-Bold="true"></asp:Label>
            <br /><br />
            <asp:Label ID="dob1" runat="server" Text="Date of Birth: "></asp:Label>
            <asp:TextBox ID="_dob1" TextMode="Date" runat="server" Width="380"  style="margin-left:34px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Dept1" runat="server" Text="Department:" ></asp:Label>
            <asp:DropDownList ID="_dept1" runat="server" Width="380" style="margin-left:40px" >
            </asp:DropDownList>
            <br /><br />
            <asp:Label ID="JoinDate1" runat="server" Text="Joining Date: "></asp:Label>
            <asp:TextBox ID="_JoinDate1" TextMode="Date" runat="server" Width="380"  style="margin-left:36px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Email1" runat="server" Text="Email: "></asp:Label>
            <asp:TextBox ID="_Email1" TextMode="Email" runat="server" Width="380"  style="margin-left:99px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Contact1" runat="server" Text="Contact no: "></asp:Label>
            <asp:TextBox ID="_Contact1" TextMode="Phone" runat="server" Width="380"  style="margin-left:49px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="Address1" runat="server" Text="Address: "></asp:Label>
            <asp:TextBox ID="_Address1" runat="server" Width="380"  style="margin-left:74px"></asp:TextBox>
            <br /><br />
            <asp:Label ID="TeacherType" runat="server" Text="Type:" ></asp:Label>
            <asp:DropDownList ID="_TeacherType" runat="server" Width="380" style="margin-left:103px" >
            </asp:DropDownList>
            
            <br /><br />
            <asp:Button ID="AddTeacher" runat="server" Text="Add" style="margin-left: 100%; padding-left: 30px; padding-right: 30px;" OnClick="AddTeacher_Click" />
        </div>

    </div>
</asp:Content>

