using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class administrator_admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_id"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        else
        {
            if(Session["user_type"].ToString() != "Admin")
            {
                Response.Redirect("not_admin");
            }
        }

        string full_name =ThesysController.GetStringFromQuery("SELECT CONCAT(last_name,', ',first_name) FROM v_Admins");
        lblUserFullName_Header.Text = full_name;
        lblUserFullName_Panel.Text = full_name;
        lblUserFullName_Sidebar.Text = full_name;

        if (!IsPostBack)
        {

        }
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("../Default.aspx");
    }
}
