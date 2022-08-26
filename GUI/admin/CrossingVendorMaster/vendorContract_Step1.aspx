<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_Step1.aspx.cs" Inherits="GUI_admin_CrossingVendorMaster_vendorContract_Step1" %>

<%@ Register Assembly="Anthem" Namespace="Anthem" TagPrefix="anthem" %>
<%@ Register Assembly="Anthem.AutoSuggest" Namespace="Anthem" TagPrefix="Anthem" %>
<%@ Import Namespace="System.Data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">  
    var FORMNAME="ctl00_MyCPH1_";  
    function FillVendor()
    {        
        var arr;
        var option;
        var ADD_EDIT_VAL="";
        if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="")
        {
            alert("Plz Select Vendor Type :");
            document.getElementById(FORMNAME+"DDL_Vendor_Type").focus();
            return false;
        }
//        document.getElementById(FORMNAME+"TR_VendDetail").style.display ="block";
//        document.getElementById(FORMNAME+"TR_VendDetail_1").style.display ="block";
//        
//        document.getElementById(FORMNAME+"TR_VendDetail_2").style.display ="block";
//        document.getElementById(FORMNAME+"TR_VendDetail_3").style.display ="block";
//        //alert("hi..1")
//        if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="01")
//        {
//            document.getElementById(FORMNAME+"TR_Attached").style.display ="block";
//            document.getElementById(FORMNAME+"TR_ContrFor").style.display ="block";
//            document.getElementById(FORMNAME+"TR_BA").style.display ="none";
//            document.getElementById(FORMNAME+"TR_3PL").style.display ="none";
//        }
//        else if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="02")
//        {
//            document.getElementById(FORMNAME+"TR_Attached").style.display ="none";
//            document.getElementById(FORMNAME+"TR_ContrFor").style.display ="none";
//            document.getElementById(FORMNAME+"TR_BA").style.display ="block";
//            document.getElementById(FORMNAME+"TR_3PL").style.display ="none";
//        }
//        else if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="03")
//        {
//            document.getElementById(FORMNAME+"TR_Attached").style.display ="none";
//            document.getElementById(FORMNAME+"TR_ContrFor").style.display ="none";
//            document.getElementById(FORMNAME+"TR_BA").style.display ="none";
//            document.getElementById(FORMNAME+"TR_3PL").style.display ="block";
//        }
//        
//        document.getElementById(FORMNAME+"txtVedor_ctl00").innerText = "";
//        document.getElementById(FORMNAME+"txtVedor__SelectedValue").innerText = "";
//        return true;
    } 
    
    function OnSubmitCheck()
    {
        if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="")
        {
            alert("Plz Select Vendor Type :");
            document.getElementById(FORMNAME+"DDL_Vendor_Type").focus();
            return false;
        }
        if(document.getElementById(FORMNAME+"Rd_Add").checked==false && document.getElementById(FORMNAME+"Rd_Edit").checked==false)
        {
            alert("Plz Select Add/Edit Option :");
            document.getElementById(FORMNAME+"Rd_Add").focus();
            return false;      
        }
        if(document.getElementById(FORMNAME+"txtVedor_ctl00").value=="")
        {
            alert("Plz Select Vendor :");
            document.getElementById(FORMNAME+"txtVedor_ctl00").focus();
            return false;
        }
        
    }
    </script>

    <div>
        <table>
            <tr>
                <td>
                    <br />  
                       
                    <table border="0" style="width: 7.0in" align="left" cellpadding="3" cellspacing="1"
                        class="boxbg">
                        <tr bgcolor="#ffffff">
                            <td class="bgbluegrey" colspan="2" align="left">
                                <font class="bluefnt"><b>Vendor Contract Step1 : Crossing Vendor Contract Criteria</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td>
                                <font class="blackfnt">Select Vendor Type</font></td>
                            <td>
                                <font class="blackfnt">                                    
                                
                                        <asp:DropDownList ID="DDL_Vendor_Type" CssClass="blackfnt" runat="server"  onchange="javascript:FillVendor()">
                                            <asp:ListItem Value=""> Select </asp:ListItem>
                                            <asp:ListItem Value="0" Text="Crossing Vendor"></asp:ListItem>
                                        </asp:DropDownList>
                                                                
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_VendDetail_1" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Select Add/Edit</font></td>
                            <td>
                                <font class="blackfnt">                                  
                                    <asp:RadioButton runat="server" ID="Rd_Add" Text="Add" GroupName="AddEdit" onclick="javascript:return FillVendor()"/>
                                    <asp:RadioButton runat="server" ID="Rd_Edit" Text="Edit" GroupName="AddEdit" onclick="javascript:return FillVendor()"/>                                                              
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_VendDetail_2" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Select Vendor</font></td>
                            <td>
                                <font class="blackfnt">
                                    <Anthem:AutoSuggestBox runat="server" ID="txtVedor" DataKeyField="vendorcode" TextBoxDisplayField="vendorname"
                                        ItemNotFoundMessage="No vendor found!" Required="false" OnTextChanged="txtVedor_TextChanged">
                                       <HeaderTemplate>
                                           
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0">
                                                <tr class="blackfnt">
                                                    <td nowrap>
                                                        <%# ((DataRowView)Container.DataItem)["vendorcode"]%>
                                                    </td>
                                                    <td width="20" align="center" nowrap> : </td>
                                                    <td nowrap>
                                                        <%# ((DataRowView)Container.DataItem)["vendorname"]%>
                                                    </td>                    
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </Anthem:AutoSuggestBox>
                                </font>
                            </td>
                        </tr>
                        
                        <tr class="bgbluegrey" id="TR_VendDetail_3" runat="server" visible="true">
                            <td colspan="2" align="center">
                                <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="groove"
                                    Text="Submit" OnClick="Step1_Click" OnClientClick="javascript:return OnSubmitCheck()" />
                            </td>
                        </tr>
                    </table>
                   
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

