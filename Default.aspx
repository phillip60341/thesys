<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Thesys | Login</title>

    <%--bootstrap-3.3.7/dist/css/bootstrap.min.css--%>
    <link rel="stylesheet" type="text/css" href="bootstrap-3.3.7/dist/css/bootstrap.min.css"/>
    <%--<a href="Web.Debug.config">Web.Debug.config</a>--%>
    <script src='<%=ResolveUrl("~/js/jquery-3.1.0.min.js")%>'></script>
    <script src='<%=ResolveUrl("~/bootstrap-3.3.7/dist/js/bootstrap.min.js")%>'></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id ="container">

        <div class ="row-left">
            <div class="col-lg-9">

            </div>

        <div class ="row">
            <div class ="col-lg-12">
                <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width:100%; height:100%; ">

  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner">
    <div class="item active">
      <img src="images/UMak_Oval.jpg" alt="Los Angeles"/>
    </div>

    <div class="item">
      <img src="images/hpsb.jpg" alt="Chicago"/>
    </div>

    <div class="item">
      <img src="images/umakfull.jpg" alt="New York"/>
    </div>
  </div>

  <!-- Left and right controls 
  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right"></span>
    <span class="sr-only">Next</span>
  </a>-->
</div>

            </div>
            <div style="background-color:rgba(0,0,0,0.2);border-radius:4px;width:300px;height:600px;position:absolute;padding:25px;left:70%;top:50px;">
                <h2><center>LOGIN</center></h2><br><br>
                <%--<form action="/action_page.php">--%>
                    <div class="form-group">
                        <label for="email">Username: </label>
                        <%--<input type="email" class="form-control" id="email" placeholder="Enter username" name="email"/>--%>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" Placeholder="Enter username"></asp:TextBox>
                    </div>
    
                     <div class="form-group">
                     <label for="pwd">Password: </label>
                     <%--<input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pwd"/>--%>
                     <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Enter password"></asp:TextBox>
                     </div>
                     <%--<button type="submit" class="btn btn-default">Login</button>--%>
                     <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-default" Text="Login" OnClick="btnLogin_Click"/>
                <%--</form>--%>
            </div>
        </div>

        </div>

        <div id="footer">
            <center>All Rights Reserved.</center>
        </div>
        
    </div>
    </form>
</body>
</html>
