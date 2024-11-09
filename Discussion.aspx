<%@ Page Title="Gryphon - Discussion" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Discussion.aspx.cs" Inherits="_Discussion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style>
        
		#bodysheet.container {
            /*border-radius: 10px;*/
			/*box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);*/
			/*margin: 20px auto;*/
			padding: 20px;
			/*background-color: #FFFFFF;*/
			/*color: black;*/
			display: flex;
			flex-direction: column;
			align-items: center;
			max-width: 90%;
			min-height: 80vh;
            position: absolute;
            top: 10vh;
            left: 5%;
            
            /*outline: 1px solid #ABABAB;*/
		}
        .widget-post {
            border-radius: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
        }
        #post-header-title.widget-post__header {
            padding: .2em .5em;
            background-image: linear-gradient(to right, #007582, #00A69C); /* add gradient background */
            color: #fff; /* change text color to white */
            text-align: center; /* center align text */
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            width: 800px;
            min-width:100px;
        }
        #post-info-title.widget-post__info {
            background-color: #EBF4F6;
            border-bottom: 1px solid #b0b0b0;
        }
        #post-text-title.widget-post__text {
            background-color: white;
            padding:15px 15px 15px 15px;
        }

        #post-footer-widgets.widget-post__actions {
            width: 100%;
            color: #a2a6a7;
            background-color: #ececec;
            padding: .5em;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
        }
        #createPost.widget-post {
            padding: 0px;
            width: 800px;
            min-width:800px;
            border-radius: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
            max-height:294px;
            min-height:294px;
        }
        #createPost.widget-post  .widget-post__header {
            background-image: linear-gradient(to right, #007582, #00A69C); 
            color: #fff; 
            text-align: center;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            max-height: 50px;
            min-height: 50px;
        }
        #createPost.widget-post .Input_post {
            width: 100%;
            height: 100%;
            resize: none;
            overflow:hidden;
            border: none;
            padding: 15px 15px 15px 15px;
            outline: none;
            min-height: 200px;
            max-height: 200px;
            background-color: white;
        }
       #createPost.widget-post .widget-post__actions{
            width: 100%;
            color: #a2a6a7;
            background-color: #ececec;
            padding: .5em;
            border-bottom-left-radius: 20px;
            border-bottom-right-radius: 20px;
            position: relative;
            top: -6px;
       }
    </style>
	<script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
		}
    </script>
</asp:Content>
<asp:Content ID="Discussion" ContentPlaceHolderID="body" Runat="Server">
     <div class="container" id="bodysheet">
		 <div class="widget-post col-sm" id="createPost">
             <div class="container widget-post__header">
                 <h1>CREATE POST</h1>
             </div>
             <div>
                 <asp:TextBox ID="InputPost" TextMode="MultiLine" runat="server" class="Input_post" Placeholder="Create a new Post..."></asp:TextBox>
             </div>
             <div class="widget-post__actions">
                 <asp:Button ID="disPost" runat="server" Text="Post" OnClick="disPost_Click"/>
             </div>
         </div>
         <br />
         
         <asp:DataList ID="disPosts" runat="server" aria-labelledby="post-header-title">
            <ItemTemplate>
                <div class="widget-post" id="posts">
                    <div class="container widget-post__header" id="post-header-title"></div>
                    <div class="container widget-post__info" id="post-info-title">
                      <div class="row">
                          <div class="col-sm" style="max-width:70px">
                              <asp:Image ID="profile_pic" CssClass="profile-pic" runat="server" Height="50px" Width="50px" ImageUrl='<%# Eval("profilePic") %>' />
                          </div>
                          <div class="col-sm" style="padding-top:12px">
                              <asp:Label ID="userIDLabel" runat="server" Text='<%# Eval("displayName") %>' />
                          </div>
                          <div class="col-sm" style="text-align:right">
                              <asp:Label ID="time" style="font-size: 12px;" runat="server" Text='<%# Eval("creation_time") %>' />
                          </div>
                      </div>
                  </div> 
                  <div class="container widget-post__text"id="post-text-title">
                  <asp:Label ID="disPostLabel" runat="server" Text='<%# Eval("text") %>'/>  
                    <br />
                  </div>
                  <div class="widget-post__actions" id="post-footer-widgets">
                    <button type="button" class="btn ">
                      Like
                    </button>
                    <button type="button" class="btn">
                      Comment
                    </button>
                  </div>
                </div>
                <br />  
            </ItemTemplate>  
        </asp:DataList> 
	 </div>
</asp:Content>
