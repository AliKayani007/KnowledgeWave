<%@ Page Title="Gryphon - Profile" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Profilepage.aspx.cs" Inherits="ProfilePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
        
		#bodysheet.container {
            border-radius: 10px;
			box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
			margin: 20px auto;
			padding: 20px;
			background-color: #EBF4F6;
			color: black;
			display: flex;
			flex-direction: column;
			align-items: center;
			max-width: 50%;
			min-height: 80vh;
			position: absolute;
            top: 10vh;
            left: 50vh;
		}
		#bodysheet label {
			display: block;
			margin-bottom: 10px;
			font-weight: bold;
			font-size: 14px;
			color: #00a69c;
			text-align: left;
			width: 100%;
		}
		#bodysheet .TextField {
			min-width: 800px;
			width: 100%;
			padding: 10px;
			margin-bottom: 20px;
			border: none;
			font-size: 16px;
			color: #555;
			background-color: transparent;
			resize: none;
			border-bottom: 1px solid #323232;
			outline: none;
			overflow: hidden;
		}
		#bodysheet .SaveChanges {
			background-color: #00a69c;
			color: #fff;
			padding: 10px 20px;
			border: none;
			border-radius: 5px;
			font-size: 16px;
			cursor: pointer;
			transition: all 0.3s ease-in-out;
		}
		#bodysheet .SaveChanges:hover {
			background-color: #fff;
			color: #00a69c;
			box-shadow: 0px 0px 10px #00a69c;
		}
		.profile-pic {
			width: 200px;
			height: 200px;
			border-radius: 50%;
			background-color: #fff;
			box-shadow: 0px 0px 10px #00a69c;
			margin-bottom: 20px;
			overflow: hidden;
		}
		.profile-pic img {
			width: 100%;
			height: 100%;
			object-fit: cover;
		}
	    input[type="file"]::-webkit-file-upload-button {
			/*visibility: hidden;*/
		}
		input[type="file"] {
			  opacity: 1;
			  position: absolute;
			  z-index: 1;
		}
		

    </style>
	<script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</asp:Content>
<asp:Content ID="Home" ContentPlaceHolderID="body" Runat="Server">
        
	<div class="container" id="bodysheet">
        <div class="profile-pic">
			<asp:Image ID="DP" runat="server" AlternateText="Profile Picture" ImageUrl="https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png" /> 
			<asp:FileUpload ID="ProfilePic" runat="server" Text="Edit"/>Edit
        </div>
		<div>
			<asp:Label ID="Label1" runat="server" Text=""></asp:Label>
			<label for="display-name">Display Name: <asp:Button ID="EditName" runat="server" Text="Edit" OnClick="EditName_Click" /></label>
			<asp:TextBox ID="OldName" runat="server" CssClass="TextField" ReadOnly="true"></asp:TextBox>
			<asp:TextBox ID="NewName" runat="server" CssClass="TextField" placeholder="Enter your name..."></asp:TextBox>
			<label for="bio">Bio:  <asp:Button ID="EditBio" runat="server" Text="Edit" OnClick="EditBio_Click" /></label>
			<asp:TextBox ID="OldBio" runat="server" CssClass="TextField"  TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
			<asp:TextBox ID="NewBio" runat="server" CssClass="TextField"  TextMode="MultiLine" placeholder="Enter your bio here..."></asp:TextBox>
		</div>
		<asp:Button ID="Save_Changes" runat="server" Text="Save Changes" CssClass="SaveChanges" OnClick="Save_Changes_Click"/>
		<asp:Button ID="Follow" runat="server" Text="Follow" CssClass="SaveChanges" OnClick="Follow_Click"/>
		<asp:Button ID="Following" runat="server" Text="Following" CssClass="SaveChanges" OnClick="Following_Click"/>
	</div>

	<%--<div class="container" id="bodysheet">
		<asp:Image ID="DP" runat="server" Height="150px" Width="150px" BorderColor="Red" BorderWidth="5px"/>
	</div>--%>
</asp:Content>
