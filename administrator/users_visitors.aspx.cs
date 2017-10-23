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

public partial class administrator_users_visitors : System.Web.UI.Page
{
    static int view_mode = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            switch (Request.QueryString["mode"])
            {
                case "active":
                    view_mode = 1;
                    ddlView.SelectedValue = "1";
                    //ThesysController.PopulateGridView(gvActiveStudents, "SELECT * FROM v_Students WHERE active=1");
                    DisplayVisitors(1);
                    break;

                case "inactive":
                    view_mode = 0;
                    ddlView.SelectedValue = "0";
                    //ThesysController.PopulateGridView(gvInactiveStudents, "SELECT * FROM v_Students WHERE active=0");
                    DisplayVisitors(0);
                    break;

                default:
                    Response.Redirect("dashboard.aspx");
                    break;
            }
        }
    }

    protected void DisplayVisitors(int mode)
    {
        if (mode == 1)
        {
            ThesysController.PopulateGridView(gvActiveVisitors, "SELECT * FROM v_Visitors WHERE active=1");
        }
        else
        {
            ThesysController.PopulateGridView(gvInactiveVisitors, "SELECT * FROM v_Visitors WHERE active=0");
        }
    }

    protected void btnAddVisitor_Click(object sender, EventArgs e)
    {
        string last_name, first_name, middle_name, username;

        username = add_txtUserName.Text.ToString();
        last_name = add_txtLastName.Text.ToString();
        first_name = add_txtFirstName.Text.ToString();
        middle_name = add_txtMiddleName.Text.ToString();

        byte[] hashedBytes;
        // PASSWORD
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
        UTF8Encoding encoder = new UTF8Encoding();
        hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(add_txtPassword.Text.ToString()));

        //string addQuery = "INSERT INTO tblUsers(user_name,last_name,first_name,middle_name,active,type,date_added,expiry_date) VALUES(@user_name,@last_name,@first_name,@middle_name,1,'Visitor',GETDATE(),GETDATE())";
        string addQuery = "INSERT INTO tblUsers(user_name,last_name,first_name,middle_name,active,type,date_added,expiry_date) VALUES(@user_name,@last_name,@first_name,@middle_name,1,'Visitor',GETDATE(),DATEADD(DAY,30,GETDATE()))";
        string[] addParameters = {"@user_name","@last_name","@first_name","@middle_name"};
        string[] addValues = {username,last_name,first_name,middle_name};

        ThesysController.QueryExecuteWithParameters(addQuery, addParameters, addValues);

        using (SqlConnection con = new SqlConnection(ThesysController.ConnectionString))
        {
            string query = "INSERT INTO tblPasswords(user_id,password,active,datetime_added) VALUES((SELECT MAX(id) FROM tblUsers),@hashedBytes,1,GETDATE())";
            SqlCommand command = new SqlCommand(query, con);
            command.CommandType = CommandType.Text;

            command.Parameters.AddWithValue("@hashedBytes", hashedBytes);
            con.Open();
            command.ExecuteNonQuery();
        }

        Response.Redirect("dashboard.aspx");
    }

    protected void ddlView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = sender as DropDownList;

        if (ddl.SelectedValue == "1")
        {
            Response.Redirect("users_visitors.aspx?mode=active");
        }
        else
        {
            Response.Redirect("users_visitors.aspx?mode=inactive");
        }
    }

    protected void gvActiveVisitors_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = e.NewEditIndex;

        DisplayVisitors(view_mode);
    }

    protected void gvActiveVisitors_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = -1;

        DisplayVisitors(view_mode);
    }

    protected void gvActiveVisitors_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = sender as GridView;
        HiddenField hdnVisitorID = gv.Rows[e.RowIndex].FindControl("hdnVisitorID") as HiddenField;

        string visitor_id = hdnVisitorID.Value.ToString();

        //Response.Redirect(student_id);
        string query = "UPDATE tblUsers SET active=0 WHERE id=" + visitor_id;
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayVisitors(view_mode);
    }

    protected void gvInactiveVisitors_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = sender as GridView;

        HiddenField hdnVisitorID = gv.Rows[e.RowIndex].FindControl("hdnVisitorID") as HiddenField;

        string query = "UPDATE tblUsers SET active=1 WHERE id=" + hdnVisitorID.Value.ToString();
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayVisitors(view_mode);
    }

    protected void gvActiveVisitors_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = sender as GridView;
        HiddenField e_hdnVisitorID = gv.Rows[e.RowIndex].FindControl("e_hdnVisitorID") as HiddenField;
        TextBox e_txtFirstName = gv.Rows[e.RowIndex].FindControl("e_txtFirstName") as TextBox;
        TextBox e_txtMiddleName = gv.Rows[e.RowIndex].FindControl("e_txtMiddleName") as TextBox;
        TextBox e_txtLastName = gv.Rows[e.RowIndex].FindControl("e_txtLastName") as TextBox;

        string first_name, middle_name, last_name, visitor_id;
        first_name = e_txtFirstName.Text.ToString();
        middle_name = e_txtMiddleName.Text.ToString();
        last_name = e_txtLastName.Text.ToString();
        visitor_id = e_hdnVisitorID.Value.ToString();

        string updateQuery = "UPDATE tblUsers SET first_name=@first_name,middle_name=@middle_name,last_name=@last_name WHERE id=@visitor_id";
        string[] updateParameters = {"@first_name","@middle_name","@last_name","@visitor_id"};
        string[] updateValues = {first_name,middle_name,last_name,visitor_id };

        ThesysController.QueryExecuteWithParameters(updateQuery, updateParameters, updateValues);

        Response.Redirect("dashboard.aspx");

    }
}