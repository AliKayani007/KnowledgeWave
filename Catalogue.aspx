<%@ Page Title="Gryphon - Catalogue" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Catalogue.aspx.cs" Inherits="_Catalogue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .Catalogue_Content {
            position: absolute;
            top: 7.5vh;
            left: 2.5vh;
            padding-bottom: 50px;
        }
        .Course, .Teacher {
            position: relative;
            background-color: #009B9C;
            width: 100vh;
            height: 100px;
            color: white;
            font-size: 20px;
            font-weight: 400;
            left: 50vh;
            padding-top: 20px;
            padding-left: 20%;
        }
        .Course:hover, .Teacher:hover{
            background-color: #09b4b5;
        }
        .headerTag{
            position: relative;
            color: #009B9C ;
            left: 90vh;
            padding-top: 20px;
            padding-bottom: 20px;
            font-weight: 800;
        }
        .Teacher {
            height: 125px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <div class="Catalogue_Content">
        <div>
            <h1 class="headerTag">COURSES</h1>
        </div>
      <asp:DataList ID="Courses_list" runat="server">
        <ItemTemplate>
          <div class="Course">
                <asp:Label ID="Course_label" runat="server" Text="Course: " ForeColor="#515151" Font-Bold="true"/>
                <asp:Label ID="Course_name" runat="server" Text='<%# Eval("Cname") %>'/><br />
                <asp:Label ID="Prereq_label" runat="server" Text="Pre-Requisite: " ForeColor="#515151" Font-Bold="true"/>
                <asp:Label ID="PreReq_name" runat="server" Text='<%# Eval("Pname") %>'/> 
              <br />
          </div>
        </ItemTemplate>
      </asp:DataList>
        <div>
            <h1 class="headerTag">TEACHERS</h1>
        </div>
      <asp:DataList ID="Teacher_list" runat="server">
        <ItemTemplate>
          <div class="Teacher">
              <asp:Label ID="Teacher_label" runat="server" Text="Name: " ForeColor="#515151" Font-Bold="true"/>
              <asp:Label ID="Teacher_name" runat="server" Text='<%# Eval("Name") %>'/><br />
              <asp:Label ID="Department_label" runat="server" Text="Department: " ForeColor="#515151" Font-Bold="true"/>
              <asp:Label ID="Department_name" runat="server" Text='<%# Eval("Dname") %>'/><br />
              <asp:Label ID="Date_label" runat="server" Text="Joined at: " ForeColor="#515151" Font-Bold="true"/>
              <asp:Label ID="Join_date" runat="server" Text='<%# Eval("Date") %>'/> 
              <br />
          </div>
        </ItemTemplate>
      </asp:DataList>
    </div>
</asp:Content>