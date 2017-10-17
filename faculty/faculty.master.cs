using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class faculty_faculty : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_id"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        else
        {
            if (Session["user_type"].ToString() != "Faculty")
            {
                Response.Redirect("not_faculty");
            }
        }

        string user_id = (string)Session["user_id"];

        DataSet dsFaculty = new DataSet();
        dsFaculty = ThesysController.BindData("SELECT * FROM v_Faculties WHERE id=" + user_id);
        DataTable dtFaculty = dsFaculty.Tables[0];

        string full_name = dtFaculty.Rows[0]["last_name"].ToString() + ", " + dtFaculty.Rows[0]["first_name"].ToString();
        string college_name = dtFaculty.Rows[0]["college_name"].ToString();
        lblUserFullName_Header.Text = full_name;
        lblUserFullName_Panel.Text = full_name;
        lblUserFullName_Sidebar.Text = full_name;
        lblCollegeName.Text = college_name;
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("../Default.aspx");
    }
}
