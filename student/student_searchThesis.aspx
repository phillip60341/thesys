<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/student/student.master" CodeFile="student_searchThesis.aspx.cs" Inherits="student_student_searchThesis" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="content-header">
    <h1>
    Thesis - Undergraduate 
    <small><asp:Label ID="lblThesisType" runat="server"></asp:Label></small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Thesis</li>
    </ol>

    <div class="row">
        <div class="col-lg-9">

        </div>
        <div class="col-lg-3 text-right">
            <div>
                <table style="width:100%;">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlView" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlView_SelectedIndexChanged">
                                <asp:ListItem Value="1" Text="Parking System"></asp:ListItem>
                                <asp:ListItem Value="0" Text="Local Arena Network (LAN)"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</section>

<div class="box-body">
<form>
    <asp:GridView ID="gvThesis" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered">
        <Columns>
            <asp:TemplateField HeaderText="Thesis Title">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnThesisID" runat="server" Value='<%# Eval("thesis_id") %>' />
                    <asp:Label ID="lblThesisTitle" runat="server" Text='<%# Eval("title") %>'></asp:Label>
                </ItemTemplate>
               
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm btn-warning" CommandName="Edit" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</form>
</div>

</asp:Content>