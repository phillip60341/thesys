<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/admin.master" AutoEventWireup="true" CodeFile="thesis.aspx.cs" Inherits="administrator_thesis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<section class="content-header">
    <h1>
    Thesis
    <small><asp:Label ID="lblThesisType" runat="server"></asp:Label></small>
    </h1>
    <ol class="breadcrumb">
    <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
    <li class="active">Thesis</li>
    </ol>
     <%--MODAL--%>
    <div class="modal fade" id="modal_addThesis" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Add Thesis
                </div>
                <div class="modal-body">
                    <div class="box-body">
                        <table class="table table-bordered">
                            <tr>
                                <td>
                                    Thesis ID:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtThesisID" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Thesis Title:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtThesisTitle" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Thesis File:
                                </td>
                                <td>
                                    <asp:TextBox ID="add_txtThesisFile" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                         </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnAddThesis" runat="server" Text="Add Thesis" CssClass="btn btn-success" OnClick="btnAddThesis_Click"/>
                </div>
            </div>
        </div>
    </div>
    <%--END MODAL--%>
    <%--<div class="clearfix"></div>--%>

    <div class="row">
        <div class="col-lg-9">

        </div>
        <div class="col-lg-3 text-right">
            <div>
                <table style="width:100%;">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlView" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlView_SelectedIndexChanged">
                                <asp:ListItem Value="1" Text="Archived"></asp:ListItem>
                                <asp:ListItem Value="0" Text="Active"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="text-right">
                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modal_addThesis">Add Thesis</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</section>

<div class="box-body">

    <asp:GridView ID="gvThesis" runat="server" AutoGenerateColumns="false" CssClass="table table-bordered"
        OnRowEditing="gvThesis_RowEditing"
        OnRowCancelingEdit="gvThesis_RowCancelingEdit"
        OnRowUpdating="gvThesis_RowUpdating"
        OnRowDeleting ="gvThesis_RowArchiving">
        <EmptyDataTemplate>
            <div class="text-center">
                Nothing to Display
            </div>
        </EmptyDataTemplate>
        <Columns>
            <asp:TemplateField HeaderText="Thesis Title">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnThesisID" runat="server" Value='<%# Eval("thesis_id") %>' />
                    <asp:Label ID="lblThesisTitle" runat="server" Text='<%# Eval("title") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:HiddenField ID="e_hdnThesisID" runat="server" Value='<%# Eval("thesis_id") %>' />
                    <asp:TextBox ID="e_txtThesisTitle" runat="server" Text='<%# Eval("title") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Thesis File">
                <ItemTemplate>
                    <asp:Label ID="lblThesisFile" runat="server" Text='<%# Eval("thesis_file") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="e_txtThesisFile" runat="server" Text='<%# Eval("thesis_file") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Action">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-warning" CommandName="Edit"/>
                    <asp:Button ID="btnDelete" runat="server" Text="Set as Archive" CssClass="btn btn-sm btn-danger" CommandName="Delete" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-sm btn-success" CommandName="Update"/>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-sm btn-danger" CommandName="Cancel"/>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>

</asp:Content>