using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for ThesysController
/// </summary>
public class ThesysController
{
    public static string ConnectionString = "Server=localhost;Database=thesys;User Id=thesys_system;Password=admin";
    public static SqlConnection con = new SqlConnection(ConnectionString);

    public static DataSet BindData(string queryString)
    {
        try { con.Open(); }
        catch { con.Close(); }
        finally { con.Close(); }
        DataSet ds = new DataSet();

        SqlCommand com = new SqlCommand(queryString, con);
        SqlDataAdapter da = new SqlDataAdapter(com);
        con.Open();
        da.Fill(ds);
        con.Close();
        return ds;
    }

    public static void QueryExecuteWithParameters(string queryString, string[] qparameters, string[] qvalues)
    {

        try{con.Open();}
        catch{con.Close();}
        finally{con.Close();}
        //FOR INSERT INTO, UPDATE
        SqlCommand cmd = new SqlCommand(queryString, con);
        cmd.CommandType = CommandType.Text;

        for (int n = 0; n < qparameters.Length; n++)
        {
            cmd.Parameters.AddWithValue(qparameters[n], qvalues[n]);
        }

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        SqlConnection.ClearPool(con);
    }

    public static string GetStringFromQuery(string query)
    {
        try { con.Open(); }
        catch { con.Close(); }
        finally { con.Close(); }

        string output = "";

        SqlCommand cmd = new SqlCommand(query, con);
        con.Open();
        output = cmd.ExecuteScalar().ToString();
        con.Close();
        return output;
    }
    public static void PopulateDDL(DropDownList ddl, string query)
    {
        DataSet ds = new DataSet();
        ds = BindData(query);
        ddl.DataTextField = "text";
        ddl.DataValueField = "value";
        ddl.DataSource = ds.Tables[0];
        ddl.DataBind();
    }

    public static void PopulateGridView(GridView gv, string query)
    {
        DataSet ds = new DataSet();
        ds = BindData(query);
        gv.DataSource = ds.Tables[0];
        gv.DataBind();
    }

    public static Boolean MainLogin(string username,string password)
    {
        Boolean output = false;

        DataSet ds = new DataSet();

        using(SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand com = new SqlCommand("SELECT * FROM Admin WHERE username=@username AND password=@password", con))
            {
                con.Open();
                com.Parameters.AddWithValue("@username", username);
                com.Parameters.AddWithValue("@password", password);

                SqlDataAdapter da = new SqlDataAdapter(com);
                da.Fill(ds);
                con.Close();

                if(ds.Tables[0].Rows.Count == 0)
                {
                    output = false;
                }
                else
                {
                    output = true;
                }
            }
        }

        return output;
    }

    public ThesysController()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}