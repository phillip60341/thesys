using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class administrator_users_students : System.Web.UI.Page
{
    static int view_mode=1;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            ThesysController.PopulateDDL(add_ddlCollege, "SELECT id AS value,name as text FROM tblColleges");
            ThesysController.PopulateDDL(add_ddlProgram, "SELECT id AS value,name as text FROM tblPrograms");

            switch (Request.QueryString["mode"])
            {
                case "active":
                    view_mode = 1;
                    ddlView.SelectedValue = "1";
                    //ThesysController.PopulateGridView(gvActiveStudents, "SELECT * FROM v_Students WHERE active=1");
                    DisplayStudents(1);
                    break;

                case "inactive":
                    view_mode = 0;
                    ddlView.SelectedValue = "0";
                    //ThesysController.PopulateGridView(gvInactiveStudents, "SELECT * FROM v_Students WHERE active=0");
                    DisplayStudents(0);
                    break;

                default:
                    Response.Redirect("dashboard.aspx");
                    break;
            }
        }
    }

    protected void DisplayStudents(int mode)
    {
        if (mode==1)
        {
            ThesysController.PopulateGridView(gvActiveStudents, "SELECT * FROM v_Students WHERE active=1");
        }
        else
        {
            ThesysController.PopulateGridView(gvInactiveStudents, "SELECT * FROM v_Students WHERE active=0");
        }
        
    }

    protected void btnAddStudent_Click(object sender, EventArgs e)
    {
        string first_name, middle_name, last_name, id_number, query;
        first_name = add_txtFirstName.Text.ToString();
        middle_name = add_txtMiddleName.Text.ToString();
        last_name = add_txtLastName.Text.ToString();
        id_number = add_txtIDNumber.Text.ToString();

        byte[] hashedBytes;
        // PASSWORD
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
        UTF8Encoding encoder = new UTF8Encoding();
        hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(add_txtPassword.Text.ToString()));

        //query = "INSERT INTO tblUsers(user_name,last_name,first_name,middle_name,expiry_date,type,id_number,college_id,program_id,active,date_added) VALUES(@user_name,@last_name,@first_name,@middle_name,GETDATE(),'Student',@id_number,@college_id,@program_id,1,GETDATE())";
        query = "INSERT INTO tblUsers(user_name,last_name,first_name,middle_name,expiry_date,type,id_number,college_id,program_id,active,date_added) VALUES(@user_name,@last_name,@first_name,@middle_name,DATEADD(DAY,30,GETDATE()),'Student',@id_number,@college_id,@program_id,1,GETDATE())";
        string[] parameters = {"@user_name","@last_name","@first_name","@middle_name","@id_number","@college_id","@program_id"};
        string[] values = {add_txtUserName.Text.ToString(),add_txtLastName.Text.ToString(),add_txtFirstName.Text.ToString(),add_txtMiddleName.Text.ToString(),add_txtIDNumber.Text.ToString(),add_ddlCollege.SelectedValue.ToString(),add_ddlProgram.SelectedValue.ToString()};
        ThesysController.QueryExecuteWithParameters(query,parameters,values);

        
        //string[] password_params = {"@hashedBytes"};
        //string[] password_values = {hashedBytes.ToString()};
        //ThesysController.QueryExecuteWithParameters(query, password_params, password_values);

        using (SqlConnection con = new SqlConnection(ThesysController.ConnectionString))
        {
            query = "INSERT INTO tblPasswords(user_id,password,active,datetime_added) VALUES((SELECT MAX(id) FROM tblUsers),@hashedBytes,1,GETDATE())";
            SqlCommand command = new SqlCommand(query, con);
            command.CommandType = CommandType.Text;

            command.Parameters.AddWithValue("@hashedBytes",hashedBytes);
            con.Open();
            command.ExecuteNonQuery();
        }

        Response.Redirect("dashboard.aspx");
    }

    protected void gvStudents_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = e.NewEditIndex;

        DisplayStudents(view_mode);
    }

    protected void gvStudents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = -1;

        //ThesysController.PopulateGridView(gvActiveStudents, "SELECT * FROM v_Students");
        DisplayStudents(view_mode);
    }

    protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //Response.Redirect("RowDeleting");
        GridView gv = sender as GridView;
        HiddenField hdnStudentID = gv.Rows[e.RowIndex].FindControl("hdnStudentID") as HiddenField;

        string student_id = hdnStudentID.Value.ToString();

        //Response.Redirect(student_id);
        string query = "UPDATE tblUsers SET active=0 WHERE id=" + student_id;
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayStudents(view_mode);
    }

    protected void gvStudents_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //Response.Redirect("RowUpdating");
        GridView gv = sender as GridView;
        HiddenField e_hdnStudentID = gv.Rows[e.RowIndex].FindControl("e_hdnStudentID") as HiddenField;
        TextBox e_txtLastName = gv.Rows[e.RowIndex].FindControl("e_txtLastName") as TextBox;
        TextBox e_txtFirstName = gv.Rows[e.RowIndex].FindControl("e_txtFirstName") as TextBox;
        TextBox e_txtMiddleName = gv.Rows[e.RowIndex].FindControl("e_txtMiddleName") as TextBox;
        DropDownList e_ddlCollege = gv.Rows[e.RowIndex].FindControl("e_ddlCollege") as DropDownList;
        DropDownList e_ddlProgram = gv.Rows[e.RowIndex].FindControl("e_ddlProgram") as DropDownList;

        string student_id,last_name, first_name, middle_name, college_id, program_id;
        student_id = e_hdnStudentID.Value.ToString();
        last_name = e_txtLastName.Text.ToString();
        first_name = e_txtFirstName.Text.ToString();
        middle_name = e_txtMiddleName.Text.ToString();
        college_id = e_ddlCollege.SelectedValue.ToString();
        program_id = e_ddlProgram.SelectedValue.ToString();

        string query = "UPDATE tblUsers SET last_name=@last_name,first_name=@first_name,middle_name=@middle_name,college_id=@college_id,program_id=@program_id WHERE id=@student_id";
        string[] parameters = {"@last_name","@first_name","@middle_name","@college_id","@program_id","@student_id"};
        string[] values = {last_name,first_name,middle_name,college_id,program_id,student_id};

        ThesysController.QueryExecuteWithParameters(query, parameters, values);

        Response.Redirect("dashboard.aspx");
    }

    protected void gvStudents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row as GridViewRow;

        if (row.RowType == DataControlRowType.DataRow)
        {
            if ((row.RowState & DataControlRowState.Edit)>0)
            {
                DropDownList e_ddlCollege = row.FindControl("e_ddlCollege") as DropDownList;
                HiddenField e_hdnCollegeID = row.FindControl("e_hdnCollegeID") as HiddenField;

                DropDownList e_ddlProgram = row.FindControl("e_ddlProgram") as DropDownList;
                HiddenField e_hdnProgramID = row.FindControl("e_hdnProgramID") as HiddenField;

                ThesysController.PopulateDDL(e_ddlCollege, "SELECT id AS value,name as text FROM tblColleges");
                e_ddlCollege.SelectedValue = e_hdnCollegeID.Value;

                ThesysController.PopulateDDL(e_ddlProgram, "SELECT id as value,name as text FROM tblPrograms");
                e_ddlProgram.SelectedValue = e_hdnProgramID.Value;

            }
            else
            {

            }
        }
    }

    protected void ddlView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = sender as DropDownList;

        if(ddl.SelectedValue == "1")
        {
            Response.Redirect("users_students.aspx?mode=active");
        }
        else
        {
            Response.Redirect("users_students.aspx?mode=inactive");
        }
    }

    protected void gvInactiveStudents_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = sender as GridView;

        HiddenField hdnStudentID = gv.Rows[e.RowIndex].FindControl("hdnStudentID") as HiddenField;

        string query = "UPDATE tblUsers SET active=1 WHERE id=" + hdnStudentID.Value.ToString();
        ThesysController.QueryExecuteWithParameters(query,new string[0],new string[0]);
        DisplayStudents(view_mode);
    }
}