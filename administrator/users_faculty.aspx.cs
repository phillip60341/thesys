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

public partial class administrator_users_faculty : System.Web.UI.Page
{
    static int view_mode = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ThesysController.PopulateDDL(add_ddlCollege, "SELECT name as text,id as value FROM tblColleges");

            switch (Request.QueryString["mode"])
            {
                case "active":
                    view_mode = 1;
                    ddlView.SelectedValue = "1";
                    DisplayFaculties(view_mode);
                    break;

                case "inactive":
                    view_mode = 0;
                    ddlView.SelectedValue = "0";
                    DisplayFaculties(view_mode);
                    break;

                default:
                    Response.Redirect("dashboard.aspx");
                    break;
            }
        }
    }

    protected void DisplayFaculties(int mode)
    {
        if (mode == 1)
        {
            ThesysController.PopulateGridView(gvActiveFaculties, "SELECT * FROM v_Faculties WHERE active=1");
        }
        else
        {
            ThesysController.PopulateGridView(gvInactiveFaculties, "SELECT * FROM v_Faculties WHERE active=0");
        }
    }

    protected void ddlView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = sender as DropDownList;

        if (ddl.SelectedValue == "1")
        {
            Response.Redirect("users_faculty.aspx?mode=active");
        }
        else
        {
            Response.Redirect("users_faculty.aspx?mode=inactive");
        }
    }

    protected void btnAddFaculty_Click(object sender, EventArgs e)
    {
        string last_name, first_name, middle_name, college_id, username, insertQuery;
        first_name = add_txtFirstName.Text.ToString();
        middle_name = add_txtMiddleName.Text.ToString();
        last_name = add_txtLastName.Text.ToString();
        college_id = add_ddlCollege.SelectedValue.ToString();
        username = add_txtUserName.Text.ToString();

        byte[] hashedBytes;
        // PASSWORD
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
        UTF8Encoding encoder = new UTF8Encoding();
        hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(add_txtPassword.Text.ToString()));

        insertQuery = "INSERT INTO tblUsers(user_name,last_name,first_name,middle_name,type,college_id,active,date_added) VALUES(@user_name,@last_name,@first_name,@middle_name,'Faculty',@college_id,1,GETDATE())";
        string[] insertParameters = {"@user_name","@last_name","@first_name","@middle_name","@college_id"};
        string[] insertValues = {username,last_name,first_name,middle_name,college_id };

        ThesysController.QueryExecuteWithParameters(insertQuery,insertParameters,insertValues);

        using (SqlConnection con = new SqlConnection(ThesysController.ConnectionString))
        {
            string query = "";
            query = "INSERT INTO tblPasswords(user_id,password,active,datetime_added) VALUES((SELECT MAX(id) FROM tblUsers),@hashedBytes,1,GETDATE())";
            SqlCommand command = new SqlCommand(query, con);
            command.CommandType = CommandType.Text;

            command.Parameters.AddWithValue("@hashedBytes", hashedBytes);
            con.Open();
            command.ExecuteNonQuery();
        }

        Response.Redirect("dashboard.aspx");
    }

    protected void gvActiveFaculties_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = e.NewEditIndex;

        DisplayFaculties(view_mode);
    }

    protected void gvActiveFaculties_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = -1;

        DisplayFaculties(view_mode);
    }

    protected void gvActiveFaculties_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row as GridViewRow;

        if (row.RowType == DataControlRowType.DataRow)
        {
            if ((row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList e_ddlCollege = row.FindControl("e_ddlCollege") as DropDownList;
                HiddenField e_hdnCollegeID = row.FindControl("e_hdnCollegeID") as HiddenField;

                ThesysController.PopulateDDL(e_ddlCollege, "SELECT id AS value, name AS text FROM tblColleges");
                e_ddlCollege.SelectedValue = e_hdnCollegeID.Value;
            }
        }
    }

    protected void gvActiveFaculties_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = sender as GridView;
        HiddenField hdnFacultyID = gv.Rows[e.RowIndex].FindControl("hdnFacultyID") as HiddenField;

        string faculty_id = hdnFacultyID.Value.ToString();

        string query = "UPDATE tblUsers SET active=0 WHERE id=" + faculty_id;
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayFaculties(view_mode);
    }

    protected void gvActiveFaculties_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = sender as GridView;

        HiddenField e_hdnFacultyID = gv.Rows[e.RowIndex].FindControl("e_hdnFacultyID") as HiddenField;
        TextBox e_txtLastName = gv.Rows[e.RowIndex].FindControl("e_txtLastName") as TextBox;
        TextBox e_txtFirstName = gv.Rows[e.RowIndex].FindControl("e_txtFirstName") as TextBox;
        TextBox e_txtMiddleName = gv.Rows[e.RowIndex].FindControl("e_txtMiddleName") as TextBox;
        DropDownList e_ddlCollege = gv.Rows[e.RowIndex].FindControl("e_ddlCollege") as DropDownList;

        string last_name, first_name, middle_name, college_id,faculty_id,updateQuery;

        last_name = e_txtLastName.Text.ToString();
        first_name = e_txtFirstName.Text.ToString();
        middle_name = e_txtMiddleName.Text.ToString();
        college_id = e_ddlCollege.SelectedValue.ToString();
        faculty_id = e_hdnFacultyID.Value.ToString();

        updateQuery = "UPDATE tblUsers SET last_name=@last_name,first_name=@first_name,middle_name=@middle_name,college_id=@college_id WHERE id=@faculty_id";
        string[] updateParameters = {"@last_name","@first_name","@middle_name","@college_id","@faculty_id"};
        string[] updateValues = {last_name,first_name,middle_name,college_id,faculty_id};

        ThesysController.QueryExecuteWithParameters(updateQuery, updateParameters, updateValues);

        Response.Redirect("dashboard.aspx");
    }

    protected void gvInactiveFaculties_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = sender as GridView;

        HiddenField hdnFacultyID = gv.Rows[e.RowIndex].FindControl("hdnFacultyID") as HiddenField;

        string query = "UPDATE tblUsers SET active=1 WHERE id=" + hdnFacultyID.Value.ToString();
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayFaculties(view_mode);
    }
}