<%@ Page Title="Gryphon - Search" EnableEventValidation="false"  Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="_Search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <style>
      .Search_Content {
            position: absolute;
            top: 7.5vh;
            left: 2.5vh;
            padding-bottom: 50px;
        }
      .headerTag{
            position: relative;
            color: #009B9C ;
            left: 80vh;
            padding-top: 20px;
            padding-bottom: 20px;
            font-weight: 800;
      }
      .Search {
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
      .FollowButton {
          left: 55vh;
          position: relative;
      }
  </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
  <div class="Search_Content">
    <div>
      <h1 class="headerTag">SEARCH RESULTS</h1>
      <asp:DataList ID="Search_results" runat="server" OnItemCommand="Search_results_ItemCommand">
        <ItemTemplate>
            <div class="Search">
              <asp:Image ID="Search_profile" runat="server" ImageUrl='<%# Eval("profilePic") %>' Height="50" Width="50" style="margin-left:-160px; margin-top: 5px"/>
              <asp:Label ID="Search_username" runat="server" Text='<%# Eval("username") %>' ForeColor="Black" Font-Bold="true"></asp:Label>
              <asp:Label ID="Search_displayname" runat="server" Text='<%# Eval("displayName") %>' style="margin-left: 50px"></asp:Label>
              <asp:Button ID="Profile" runat="server" Text="View Profile" CssClass="FollowButton" CommandName="ViewProfile" CommandArgument='<%# Eval("username") %>' OnClick="Profile_Click"/>
            </div>
        </ItemTemplate>
      </asp:DataList>
      <asp:Label ID="x" runat="server"></asp:Label>
    </div>
  </div>
</asp:Content>

