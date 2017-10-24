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

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {

        ThesysController.QueryExecuteWithParameters("sp_UserExpiryCheck", new string[0], new string[0]);

        string username = txtUserName.Text.ToString();

        byte[] hashedBytes;
        // PASSWORD
        MD5CryptoServiceProvider md5Hasher = new MD5CryptoServiceProvider();
        UTF8Encoding encoder = new UTF8Encoding();
        hashedBytes = md5Hasher.ComputeHash(encoder.GetBytes(txtPassword.Text.ToString()));

        DataSet ds = new DataSet();
        
        using (SqlConnection con = new SqlConnection(ThesysController.ConnectionString))
        {
            using (SqlCommand com = new SqlCommand("SELECT * FROM v_UserPasswords WHERE user_name=@username AND password=@password", con))
            {
                con.Open();
                com.Parameters.AddWithValue("@username", username);
                com.Parameters.AddWithValue("@password", hashedBytes);
                

                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    Session["user_id"] = ds.Tables[0].Rows[0]["id"].ToString();
                    Session["user_type"] = ds.Tables[0].Rows[0]["type"].ToString();
                    switch (ds.Tables[0].Rows[0]["type"].ToString())
                    {
                        case "Admin":
                            Response.Redirect("administrator/dashboard.aspx");
                            break;

                        case "Student":
                            Response.Redirect("student/dashboard.aspx");
                            break;

                        case "Faculty":
                            Response.Redirect("faculty/dashboard.aspx");
                            break;

                        case "Visitor":
                            Response.Redirect("visitor/dashboard.aspx");
                            break;
                    }
                }
                else
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }
    }
}