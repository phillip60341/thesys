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

public partial class administrator_users_admins : System.Web.UI.Page
{
    static int view_mode = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //ThesysController.PopulateGridView(gvActiveAdmins, "SELECT * FROM v_Admins WHERE active=1");

            switch (Request.QueryString["mode"])
            {
                case "active":
                    view_mode = 1;
                    ddlView.SelectedValue = "1";
                    break;
                case "inactive":
                    view_mode = 0;
                    ddlView.SelectedValue = "0";
                    break;
                default:
                    Response.Redirect("dashboard.aspx");
                    break;
            }

            DisplayAdmins(view_mode);
        }
    }

    protected void DisplayAdmins(int mode)
    {
        if (mode==1)
        {
            ThesysController.PopulateGridView(gvActiveAdmins, "SELECT * FROM v_Admins WHERE active=1");
        }
        else
        {
            ThesysController.PopulateGridView(gvInactiveAdmins, "SELECT * FROM v_Admins WHERE active=0");
        }
    }

    protected void btnAddAdministrator_Click(object sender, EventArgs e)
    {
        string last_name, first_name, middle_name, username;
        last_name = add_txtLastName.Text.ToString();
        first_name = add_txtFirstName.Text.ToString();
        middle_name = add_txtMiddleName.Text.ToString();
        username = add_txtUserName.Text.ToString();

        byte[] hashedBytes;
        // PASSWORD
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
        UTF8Encoding encoder = new UTF8Encoding();
        hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(add_txtPassword.Text.ToString()));

        string addQuery = "INSERT INTO tblUsers(user_name,last_name,first_name,middle_name,date_added,active,type) VALUES(@username,@last_name,@first_name,@middle_name,GETDATE(),1,'Admin')";
        string[] addParameters = {"@username","@last_name","@first_name","@middle_name"};
        string[] addValues = { username, last_name, first_name, middle_name };

        ThesysController.QueryExecuteWithParameters(addQuery, addParameters, addValues);

        using (SqlConnection con = new SqlConnection(ThesysController.ConnectionString))
        {
            string passwordquery = "INSERT INTO tblPasswords(user_id,password,active,datetime_added) VALUES((SELECT MAX(id) FROM tblUsers),@hashedBytes,1,GETDATE())";
            SqlCommand command = new SqlCommand(passwordquery, con);
            command.CommandType = CommandType.Text;

            command.Parameters.AddWithValue("@hashedBytes", hashedBytes);
            con.Open();
            command.ExecuteNonQuery();
        }

        Response.Redirect("dashboard.aspx");
    }

    protected void gvActiveAdmins_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView gv = sender as GridView;

        gv.EditIndex = e.NewEditIndex;

        DisplayAdmins(view_mode);
    }

    protected void gvActiveAdmins_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView gv = (GridView)sender;

        gv.EditIndex = -1;

        DisplayAdmins(view_mode);
    }

    protected void gvActiveAdmins_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = (GridView)sender;

        HiddenField e_hdnUserID = (HiddenField)gv.Rows[e.RowIndex].FindControl("e_hdnUserID");
        TextBox e_txtLastName = (TextBox)gv.Rows[e.RowIndex].FindControl("e_txtLastName");
        TextBox e_txtFirstName = (TextBox)gv.Rows[e.RowIndex].FindControl("e_txtFirstName");
        TextBox e_txtMiddleName = (TextBox)gv.Rows[e.RowIndex].FindControl("e_txtMiddleName");

        string user_id, last_name, first_name, middle_name;

        user_id = e_hdnUserID.Value.ToString();
        last_name = e_txtLastName.Text.ToString();
        first_name = e_txtFirstName.Text.ToString();
        middle_name = e_txtMiddleName.Text.ToString();

        string query = "UPDATE tblUsers SET last_name=@last_name,first_name=@first_name,middle_name=@middle_name WHERE id=@user_id";
        string[] updateparameters = {"@last_name","@first_name","@middle_name","@user_id"};
        string[] updatevalues = {last_name,first_name,middle_name,user_id};

        ThesysController.QueryExecuteWithParameters(query, updateparameters, updatevalues);

        Response.Redirect("users_admins.aspx?mode=active");
    }

    protected void ddlView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;

        if (ddl.SelectedValue == "1")
        {
            Response.Redirect("users_admins.aspx?mode=active");
        }
        else
        {
            Response.Redirect("users_admins.aspx?mode=inactive");
        }
    }

    protected void gvActiveAdmins_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gv = sender as GridView;

        HiddenField hdnUserID = (HiddenField)gv.Rows[e.RowIndex].FindControl("hdnUserID");

        string user_id = hdnUserID.Value.ToString();

        string query = "UPDATE tblUsers SET active=0 WHERE id=" + user_id;
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayAdmins(view_mode);
    }

    protected void gvInactiveAdmins_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gv = (GridView)sender;

        HiddenField hdnUserID = (HiddenField)gv.Rows[e.RowIndex].FindControl("hdnUserID");

        string query = "UPDATE tblUsers SET active=1 WHERE id=" + hdnUserID.Value.ToString();
        ThesysController.QueryExecuteWithParameters(query, new string[0], new string[0]);
        DisplayAdmins(view_mode);
        
    }
}