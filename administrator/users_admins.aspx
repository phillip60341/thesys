<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/admin.master" AutoEventWireup="true" CodeFile="users_admins.aspx.cs" Inherits="administrator_users_admins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="content-header">
    <h1>
    Users
    <small>Administrators</small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Users (Adminstrators)</li>
    </ol>

    <%--ADD ADMIN MODAL--%>
    <div class="modal fade" id="modal_addAdmin" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Add an Administrator
                </div>
                <div class="modal-body">
                <div class="box-body">
                    <table class="table table-bordered">
                        <tr>
                            <td>User Name</td>
                            <td> 
                                <asp:TextBox ID="add_txtUserName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtUserName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>  
                            </td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td>
                                <asp:TextBox ID="add_txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtPassword" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>First Name</td>
                            <td>
                                <asp:TextBox ID="add_txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtFirstName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Middle Name</td>
                            <td>
                                <asp:TextBox ID="add_txtMiddleName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtMiddleName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name</td>
                            <td>
                                <asp:TextBox ID="add_txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                                <%--<asp:RequiredFieldValidator runat="server" ControlToValidate="add_txtLastName" SetFocusOnError="true" ErrorMessage="This field is required" Font-Size="X-Small" ForeColor="Red" style="display:inline;"/>--%>
                            </td>
                        </tr>
                    </table>
                </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnAddAdministrator" runat="server" Text="Add Administrator" CssClass="btn btn-sm btn-success" OnClick="btnAddAdministrator_Click" />
                </div>
            </div>
        </div>
    </div>
    <%--END ADD ADMIN MODAL--%>
    <br />
    <div class="row">
        <div class="col-lg-8">
            
        </div>
        <div class="col-lg-4">
            <table style="width:100%;">
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlView" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlView_SelectedIndexChanged">
                            <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                            <asp:ListItem Value="0" Text="Inactive"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="text-right">
                        <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modal_addAdmin">Add a new Administrator</button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</section>

<div class="box-body">
    
    <asp:GridView ID="gvActiveAdmins" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
        OnRowEditing="gvActiveAdmins_RowEditing"
        OnRowCancelingEdit="gvActiveAdmins_RowCancelingEdit"
        OnRowUpdating="gvActiveAdmins_RowUpdating"
        OnRowDeleting="gvActiveAdmins_RowDeleting">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnUserID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnUserID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:TextBox ID="e_txtLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Middle Name">
                <ItemTemplate>
                    <asp:Label ID="lblMiddleName" runat="server" Text='<%# Eval("middle_name") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtMiddleName" runat="server" Text='<%# Eval("middle_name") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date Added">
                <ItemTemplate>
                    <asp:Label ID="lblDateAdded" runat="server" Text='<%# Eval("date_added") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="e_lblDateAdded" runat="server" Text='<%# Eval("date_added") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-warning" CommandName="Edit"/>
                    <asp:Button ID="btnDelete" runat="server" Text="Set as Inactive" CssClass="btn btn-sm btn-danger" CommandName="Delete" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-sm btn-success" CommandName="Update"/>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-sm btn-danger" CommandName="Cancel"/>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <asp:GridView ID="gvInactiveAdmins" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered" OnRowUpdating="gvInactiveAdmins_RowUpdating">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Last Name">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnUserID" runat="server" Value='<%# Eval("id") %>' />
                    <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("last_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="First Name">
                <ItemTemplate>
                    <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("first_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnActivate" runat="server" Text="Activate" CssClass="btn btn-sm btn-success" CommandName="Update" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <%--<table class="table table-bordered">
    <tr>
        <th>Last Name</th>
        <th>First Name</th>
        <th>Middle Initial</th>
        <th>Date Added</th>
        <th>Actions</th>
    </tr>
    <tr>
        <td>SampleLast</td>
        <td>SampleFirst</td>
        <td>Sample Middle</td>
        <td>Sample DateAdded</td>
        <td>
            <button type="button" class="btn btn-sm btn-danger">Delete</button>
            <button type="button" class="btn btn-sm btn-warning">Edit</button>
        </td>
    </tr>
    
    </table>--%>
</div>

</asp:Content>