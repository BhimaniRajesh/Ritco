<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    Trace="false" EnableEventValidation="false" CodeFile="vendorContract_Step1.aspx.cs"
    Inherits="GUI_Admin_Vendor_contract_vendorContract_Step1" %>
    
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
        //alert("hi..")
        //document.getElementById(FORMNAME+"TB_ContractDetail").style.display ="block";
        document.getElementById(FORMNAME+"TR_VendDetail").style.display ="block";
        document.getElementById(FORMNAME+"TR_VendDetail_1").style.display ="block";
        
        document.getElementById(FORMNAME+"TR_VendDetail_2").style.display ="block";
        document.getElementById(FORMNAME+"TR_VendDetail_3").style.display ="block";
        //alert("hi..1")
        if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="01")
        {
            document.getElementById(FORMNAME+"TR_Attached").style.display ="block";
            document.getElementById(FORMNAME+"TR_ContrFor").style.display ="block";
            document.getElementById(FORMNAME+"TR_BA").style.display ="none";
            document.getElementById(FORMNAME+"TR_3PL").style.display ="none";
        }
        else if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="08")
        {
            document.getElementById(FORMNAME+"TR_Attached").style.display ="none";
            document.getElementById(FORMNAME+"TR_ContrFor").style.display ="none";
            document.getElementById(FORMNAME+"TR_BA").style.display ="block";
            document.getElementById(FORMNAME+"TR_3PL").style.display ="none";
        }
        else if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="03")
        {
            document.getElementById(FORMNAME+"TR_Attached").style.display ="none";
            document.getElementById(FORMNAME+"TR_ContrFor").style.display ="none";
            document.getElementById(FORMNAME+"TR_BA").style.display ="none";
            document.getElementById(FORMNAME+"TR_3PL").style.display ="block";
        }
        
        document.getElementById(FORMNAME+"txtVedor_ctl00").innerText = "";
        document.getElementById(FORMNAME+"txtVedor__SelectedValue").innerText = "";
        return true;
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
        if(document.getElementById(FORMNAME+"DDL_Vendor_Type").value=="01")
        {
            if(document.getElementById(FORMNAME+"Rd_Contract_Attached").checked==false && 
               document.getElementById(FORMNAME+"Rd_Contract_Attached1").checked==false &&
               document.getElementById(FORMNAME+"Rd_Contract_Attached2").checked==false)
            {
                alert("Plz Select Vendor Contract Type :");
                document.getElementById(FORMNAME+"Rd_Contract_Attached").focus();
                return false;      
            } 
            if(document.getElementById(FORMNAME+"Ddl_Contract_For").value=="")
            {
                alert("Plz Select Contract For :");
                document.getElementById(FORMNAME+"Ddl_Contract_For").focus();
                return false;      
            }
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
                                <b>Vendor Contract Step1 : Select Vendor Contract Criteria</b>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td>
                                <font class="blackfnt">Select Vendor Type</font></td>
                            <td>
                                <font class="blackfnt">                                    
                                
                                        <asp:DropDownList ID="DDL_Vendor_Type" CssClass="blackfnt" runat="server"  onchange="javascript:FillVendor()">
                                            <asp:ListItem Value=""> Select </asp:ListItem>
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
                                            <%-- <table border="0" cellpadding="2" cellspacing="0">
                                                <tr>
                                                    <td align="left">
                                                        <b>Code </b>
                                                    </td>
                                                    <td width="10"></td>
                                                    <td align="right">
                                                        <b>Location</b>
                                                    </td>
                                                </tr>
                                            </table>--%>
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
                        <tr class="bgbluegrey" id="TR_VendDetail" runat="server" visible="true">
                            <td colspan="2" align="left">
                                <b>Vendor Contract Type Details</b>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_Attached" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Vendor Contract Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:RadioButton ID="Rd_Contract_Attached" GroupName="VednContract" runat="server"
                                        Text="Route based for THC and Distance based for PRS/DRS" />
                                    <br />
                                    <asp:RadioButton ID="Rd_Contract_Attached2" GroupName="VednContract" runat="server"
                                        Text="City based for THC and Distance based for PRS/DRS" />
                                    <br />
                                    <asp:RadioButton ID="Rd_Contract_Attached1" GroupName="VednContract" runat="server"
                                        Text="Distance based for THC/DRS/PRS" />
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_BA" runat="server" visible="true">
                            <td align="left">
                                <font class="blackfnt">Vendor Contract Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:Label ID="Lbl_BA" runat="server" CssClass="bluefnt" Font-Bold="true" Text="Cnote Based Contracts " />
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_3PL" runat="server" visible="true">
                            <td>
                                <font class="blackfnt">Vendor Contract Type</font></td>
                            <td>
                                <font class="blackfnt">
                                    <asp:Label ID="Lbl_3pl" runat="server" Font-Bold="true" Text="3PL Contracts" />
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" id="TR_ContrFor" runat="server" >
                            <td>
                                Select Contract For :
                            </td>
                            <td><%--FTL Type--%>
                                <asp:DropDownList ID="Ddl_Contract_For" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Value="1">Vendor</asp:ListItem>
                                    <asp:ListItem Value="2">Type of Movement</asp:ListItem>
                                    <asp:ListItem Value="3">Vehicle Number</asp:ListItem>
                                </asp:DropDownList>
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
