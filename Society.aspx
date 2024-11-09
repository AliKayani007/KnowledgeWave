<%@ Page Title="Gryphon - Society" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Society.aspx.cs" Inherits="_Society" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .Society_content{
            position: absolute;
            top: 7.5vh;
            left: 2.5vh;
        }
        .ListSocieties {
            width: 50vh;
            height: 90vh;
            border: 2px solid dimgrey;
            border-top-right-radius: 7px;
            border-bottom-right-radius: 7px;
/*          border-radius: 20px 20px;*/
            overflow-y: scroll;
            overflow-x:clip;
            background-color: dimgrey;
        }
        .ListSocieties::-webkit-scrollbar {
            width: 10px;
        }
        .ListSocieties::-webkit-scrollbar-thumb {
            background-color: #009B9C;
            box-shadow: inset 2px 2px 5px 0 rgba(#fff, 0.5);
            border-radius: 100px;
        }
        .ListSocieties::-webkit-scrollbar-track {
          box-shadow: inset 0 0 5px grey; 
          border-radius: 10px;
          background-color: white;
        }
        .NameSociety {
            background-color: #009B9C;
            width: 50vh;
            height: 50px;
            text-align: center;
            color: white;
            font-size: 30px;
            font-weight: 400;
        }
    </style>
</asp:Content>
<asp:Content ID="Society_Page" ContentPlaceHolderID="body" Runat="Server">
    <div class="Society_content">
      <div class="ListSocieties">
          <asp:DataList ID="Societies_list" runat="server">
              <ItemTemplate>
                  <div class="NameSociety">
                      <asp:Label ID="Society_name" runat="server" Text='<%# Eval("Name") %>'/>  
                  </div>
              </ItemTemplate>
          </asp:DataList>
      </div>
    </div>
</asp:Content>

