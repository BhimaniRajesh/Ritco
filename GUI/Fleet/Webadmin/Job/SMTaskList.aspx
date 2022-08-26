<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SMTaskList.aspx.cs" Inherits="GUI_Fleet_Webadmin_Job_TaskList" Title="Untitled Page" %>

<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <style type="text/css">
    .popupMenu {background-color:Silver;position:absolute;visibility:hidden;border-width:1px;border-style:solid;border-color:Black;}
    
    .popupHover {
	background-image:url(images/header-opened.png);
	background-repeat:repeat-x;
	background-position:left top;
	background-color:#F5F7F8;
}


</style>


<div >
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">SM Tasks Master</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
                         <td align="right">
                             
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
            
        </tr>
        
        
        
        
    </table>
    
<center>
<br />
<br />
<asp:Table runat="server" ID="tbl" Width="950px" >
<asp:TableRow HorizontalAlign="Right" >
<asp:TableCell >
    <asp:HyperLink ID="hyperAddNew" Text="Add New"  NavigateUrl="~/GUI/Fleet/Webadmin/Job/SMTaskdet.aspx"  runat="server"></asp:HyperLink>
    &nbsp;
    <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton>
    
    
</asp:TableCell>
</asp:TableRow> 
<asp:TableRow HorizontalAlign="Left" >
<asp:TableCell >
 <asp:GridView ID="gvTaskHeader" runat="server" AutoGenerateColumns="False"  Width="100%" ShowHeader="true" 
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
        CellPadding="3" DataKeyNames="SMTask_Id" 
        Font-Names="Verdana" Font-Size="8pt" 
        onrowdatabound="gvTaskHeader_RowDataBound">
        <RowStyle ForeColor="#000066" />
        <Columns>
        
        <asp:TemplateField HeaderText="Vehicle Models" SortExpression="VEH_TYPE_CODE">
              
                <ItemTemplate>
                
                 <asp:Label ID="Label1" runat="server" Text='<%# Bind("VEH_TYPE_NAME") %>'></asp:Label>
                 
                 </ItemTemplate>
                 </asp:TemplateField>
                
            <asp:TemplateField HeaderText="View" SortExpression="VEH_TYPE_CODE">

                <ItemTemplate>
                   
                    <asp:Label runat="server" Text="View" CssClass="bluefnt" ID="lblView"></asp:Label>
                    <asp:HiddenField ID="hfSMTaskID" runat="server" 
                        Value='<%# Eval("SMTask_Id", "{0}") %>' />
                    <asp:Panel ID="pnlTaskDetails"  runat="server"> 
                    
                    
                    <asp:GridView ID="gvTaskDetails" runat="server" AutoGenerateColumns="False" 
                        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                        CellPadding="3" DataKeyNames="Task_Id" Width="900px" >
                        <RowStyle ForeColor="#000066" />
                        <Columns>
                            <asp:BoundField DataField="W_GRPDESC" HeaderText="Work Group" 
                                SortExpression="W_GRPDESC" >
                                <ItemStyle Width="20%" />
                            </asp:BoundField>
                                     
                            <asp:BoundField DataField="TASKDESC" HeaderText="Description" 
                                SortExpression="TASKDESC" >
                                 <ItemStyle Width="25%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TASKTYPEDESC" HeaderText="Task Type" 
                                SortExpression="TASKTYPEDESC" >
                                <ItemStyle Width="25%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Estimated_Hrs" HeaderText="Estimated Hours" SortExpression="Estimated_Hrs" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="T_UOM" HeaderText="UOM" SortExpression="T_UOM" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SERVICE_INTERVALS_DAY" 
                                HeaderText="Service Intervals Days" SortExpression="SERVICE_INTERVALS_DAY" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SERVICE_INTERVALS_KMS" 
                                HeaderText="Service Intervals Kms" SortExpression="SERVICE_INTERVALS_KMS" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ADV_NOTIFICATION_DAY" 
                                HeaderText="Advance Notification Days" SortExpression="ADV_NOTIFICATION_DAY" >
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ADV_NOTIFACATION_KMS"
                                HeaderText="Advance Notification Kms" SortExpression="ADV_NOTIFACATION_KMS">
                                <ItemStyle Width="10%" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                    
                    </asp:Panel>
                 
              <ajaxToolkit:HoverMenuExtender ID="hme2" runat="Server"
                    HoverCssClass="popupHover"
                    PopupControlID="pnlTaskDetails"
                    PopupPosition="right"
                    TargetControlID="lblView"
                    PopDelay="50" />
                    
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:HyperLinkField DataNavigateUrlFields="SMTask_Id" DataNavigateUrlFormatString="SMTaskdet.aspx?id={0}"   
                DataTextField="SMTask_Id" DataTextFormatString="Edit" >
                <ItemStyle  CssClass="bluefnt" ForeColor="Blue" />
                </asp:HyperLinkField>
                 
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
</asp:TableCell>
</asp:TableRow> 

</asp:Table>
    

</center> 
</div>

</asp:Content>

