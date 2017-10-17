using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class visitor_visitor : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string user_id = (string)Session["user_id"];
        string query = "SELECT CONCAT(last_name,', ',first_name) FROM v_Visitors WHERE id=" + user_id;
        //Response.Redirect(user_id);
        string full_name = ThesysController.GetStringFromQuery(query);
        lblUserFullName_Header.Text = full_name;
        lblUserFullName_Panel.Text = full_name;
        lblUserFullName_Sidebar.Text = full_name;
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("../Default.aspx");
    }
}
