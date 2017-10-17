using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class student_student : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_id"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        else
        {
            if (Session["user_type"].ToString() != "Student")
            {
                Response.Redirect("not_admin");
            }
        }

        string user_id = (string)Session["user_id"];
        string query = "SELECT CONCAT(last_name,', ',first_name) FROM v_Students WHERE student_id=" + user_id;
        //Response.Redirect(user_id);
        //string full_name = ThesysController.GetStringFromQuery(query);
        

        DataSet dsStudent = new DataSet();
        dsStudent = ThesysController.BindData("SELECT * FROM v_Students WHERE student_id=" + user_id);
        DataTable dtStudent = dsStudent.Tables[0];
        string full_name = dtStudent.Rows[0]["last_name"].ToString() + ", " + dtStudent.Rows[0]["first_name"].ToString();
        string college_name = dtStudent.Rows[0]["college_name"].ToString();
        string program_name = dtStudent.Rows[0]["program_name"].ToString();

        lblUserFullName_Header.Text = full_name;
        lblUserFullName_Panel.Text = full_name;
        lblUserFullName_Sidebar.Text = full_name;

        lblCollegeName.Text = college_name;
        lblProgramName.Text = program_name;
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();

        Response.Redirect("../Default.aspx");
    }
}