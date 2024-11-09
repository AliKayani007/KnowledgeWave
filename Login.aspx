<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Login" %>

<!DOCTYPE html>
<html>

<head>
    <title>Gryphon - Login</title>
    <style>
    
    .logo {
        width: 100px;
        height: 100px;
        background-color: #FFFFFF;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2.5em;
        color: #FFFFFF;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        margin: 0 auto;
        margin-top: 30px;
        animation: pulse 5s ease-in-out infinite;
	}
    @keyframes pulse {
        0% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.2);
        }
        100% {
            transform: scale(1);
        }
    }

    body {
        background-color: #FFFFFF;
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 0;
    }

    .container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
    }

    h1 {
        font-size: 3em;
        font-weight: bold;
        margin-bottom: 0;
        color: #005D8C;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        letter-spacing: 0.1em;
    }

    h1 span {
        color: #2E2E2E;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: #FFFFFF;
        border-radius: 8px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        padding: 20px;
        margin-top: 30px;
        max-width: 400px;
        width: 100%;
        transform: translateY(50px);
        opacity: 0;
        transition: transform 0.5s ease, opacity 0.5s ease;
    }

    form.show {
        transform: none;
        opacity: 1;
    }

    input[type="text"], input[type="password"] {
		background-color: #E0E0E0;
		border: none;
		border-radius: 4px;
		box-sizing: border-box;
		font-size: 1.1em;
		margin: 10px 0;
		padding: 10px;
		width: 100%;
	}
	input[type="submit"] {
		background-color: #005D8C;
		border: none;
		border-radius: 4px;
		color: #FFFFFF;
		cursor: pointer;
		font-size: 1.1em;
		font-weight: bold;
		margin: 10px 0;
		padding: 10px;
		transition: background-color 0.3s ease;
		width: 100%;
	}
	input[type="submit"]:hover {
		background-color: #003E5D;
	}
	.error-message {
		color: #E74C3C;
		font-size: 0.9em;
		margin-top: 10px;
    }
    
	.forgot {
		color: #003E5D;
		font-size: 1.0em;
		margin-top: 10px;
         transition: color 0.3s ease;
	}
    
    .forgot:hover {
        color: #005D8C;
    }
    </style>
    <script>
        window.onload = function () {
            document.querySelector('form').classList.add('show');
        }
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
</head>

<body>
    <div class="container">
        <div class="logo"><img src='resources/logo.png' height=120 width=120 /></div>
        <h1><span>Gry</span>phon</h1>
        <form runat="server">
            <asp:TextBox ID="Username" placeholder="Username" runat="server"></asp:TextBox>
            <asp:TextBox ID="Password" TextMode="Password" placeholder="Password" runat="server"></asp:TextBox>
            <asp:Label ID="Incorrect" runat="server" Text="" CssClass="error-message"></asp:Label>
            <asp:Button ID="Login" runat="server" Text="LOGIN" OnClick="Login_Click"/>
            <span class="forgot">Forgot Password</span>
        </form>
    </div>
</body>
</html>