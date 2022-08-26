<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="start_test.aspx.cs" Inherits="Finance_Billing_Billgeneration_start" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../Billing.js"></script>

    <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
        FRM_Name="ctl00_MyCPH1_"
        function OnSubmit()
        { 
        
                                 if(document.getElementById(FRM_Name+'Txt_Customer').value=="")
                                {
                                        alert("Plz Select Enter Customer Name~Code Format")
                                        document.getElementById(FRM_Name+'Txt_Customer').focus();
                                        return false;
                                }
				                
                                var Search_Char="~"
		                        if (document.getElementById(FRM_Name+'Txt_Customer').value.indexOf(Search_Char)==-1)
		                        {
		                           alert("Invalid Customer Name~Code Format");
		                           document.getElementById(FRM_Name+'Txt_Customer').focus();
		                           return false
		                        }
		                         if(document.getElementById(FRM_Name+'Cbopaybas').value=="")
                                {
                                        alert("Plz Select Paybas");
                                        document.getElementById(FRM_Name+'Cbopaybas').focus();
                                        return false;
                                }
							  if(document.getElementById(FRM_Name+'Hnd_BIll_Business_Type_Wise_YN').value=="Y")
					          {
					            if(document.getElementById("ctl00_MyCPH1_Cb_Businesstype").value=="")
					            {
					                alert("Plz Select Business Type");
							        document.getElementById("ctl00_MyCPH1_Cb_Businesstype").focus();
							        return false;
							    }
					          }
					          if(document.getElementById(FRM_Name+'Docketnos').value=="")
					          {
					              if(document.getElementById(FRM_Name+'DT_radDate_0').checked)
                                    {
                                         
                                        if(document.getElementById(FRM_Name+'DT_txtDateFrom').value=="")
                                        {
                                            alert("Plz Enter From date")
                                            document.getElementById(FRM_Name+'DT_txtDateFrom').focus();
                                            return false;
                                        }
                                        if(document.getElementById(FRM_Name+'DT_txtDateTo').value=="")
                                        {
                                            alert("Plz Enter To date")
                                            document.getElementById(FRM_Name+'DT_txtDateTo').focus();
                                            return false;
                                        }
                                   }
                              }          							
					    
		return true;
        }
        function OnModeBlur(Obj)
        {
            var Code_ID=Obj;
            var Code_Value=Code_ID.value;
            Code_Value_Arr=Code_Value.split("~");
            document.getElementById(FRM_Name+'TR_TrnMod_Stax').style.display="block";
            document.getElementById(FRM_Name+'Lbl_WithTax').innerText="With Tax (<b>"+Code_Value_Arr[1]+"%</b>)";
        }
    </script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <div>
        <table style="width: 10in" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <center>
                        <font class="blackfnt"><b>Bill Generation </b></font>
                    </center>
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10">
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 85%;
                        height: 383px;" align="center">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Select Billing Party </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="Left">
                                <font class="blackfnt">Enter Billing party code </font>
                            </td>
                            <td style="width: 339px">
                                <asp:TextBox ID="Txt_Customer" runat="server" Width="350" BorderStyle="Groove" CssClass="blackfnt"
                                    onblur="javascript:Customer_Location_Blur(this,'Customer','N')"></asp:TextBox>
                                <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                                <div id="Abc" runat="server" class="boxbg" />
                                <%--                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server"  DropDownPanelID="Abc" >
                              <ajaxToolkit:AutoCompleteProperties TargetControlID="Txt_Customer" ServicePath="../AtlasAutoComplete.asmx" 
                                        ServiceMethod="GetCustomer" MinimumPrefixLength="1" Enabled="true" />
                              </ajaxToolkit:AutoCompleteExtender>--%>
                                <ajaxtoolkit:autocompleteextender id="extLocation" runat="server" enabled="True"
                                    completionlistitemcssclass="autocomplete_listItem" completionlisthighlighteditemcssclass="autocomplete_highlightedListItem"
                                    minimumprefixlength="1" servicemethod="GetCustomer" servicepath="../AtlasAutoComplete.asmx"
                                    targetcontrolid="Txt_Customer">
                                </ajaxtoolkit:autocompleteextender>
                                <font class="redfnt">Plz Type Initial Character OF Customer Name </font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="Left">
                                <font class="blackfnt">Pay Basis</font>
                            </td>
                            <td style="width: 339px">
                                <asp:DropDownList ID="Cbopaybas" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="P02">TBB</asp:ListItem> 
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="Left">
                                <font class="blackfnt">Mode Of Transport</font>
                            </td>
                            <td style="width: 339px">
                                <asp:DropDownList ID="Cbotrnmod" runat="server" CssClass="blackfnt" ><%--onchange="javascript:OnModeBlur(this)"--%>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px;display:none" runat="server" id="TR_TrnMod_Stax"   >
                            <td style="width: 210px" align="Left">
                                 Service Tax Details (Y/N)
                            </td>
                            <td style="width: 339px">
<%--                                <asp:RadioButton  GroupName="Tax" ID="Rd_WithTax" Text="With Tax" runat="server"/>
                                <asp:RadioButton  GroupName="Tax" ID="Rd_WOTax" Text="W/O Tax" runat="server"/>
--%>                                 
                                 <input type="radio" name="Rd_WithTax" id="Rd_WithTax" value="With Tax"   runat="server"  checked />
                                <asp:Label ID="Lbl_WithTax" runat="server" CssClass="blackfnt" runat="server" Text=""></asp:Label>
                                <input type="radio" name="Rd_WithTax" id="Rd_WOTax" value="W/O Tax"    runat="server"  />
                                W/O Tax 
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px" runat="server" id="Businesstype_tr" visible="false">
                            <td style="width: 210px" align="Left">
                                <font class="blackfnt">Business Type</font>
                            </td>
                            <td style="width: 339px">
                                <asp:DropDownList ID="Cb_Businesstype" runat="server" CssClass="blackfnt">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px">
                            <td style="width: 210px" align="Left">
                                <font class="blackfnt">
                                    <%= Session["DocketCalledAs"] %>
                                    Number</font>
                            </td>
                            <td nowrap>
                                <asp:TextBox runat="server" ID="Docketnos" Width="250" BorderStyle="Groove" CssClass="blackfnt"
                                    TextMode="MultiLine" Rows="3"></asp:TextBox><br />
                                <font class="redfnt">NOTE :- (If Multiple Plz Enter
                                    <%= Session["DocketCalledAs"] %>
                                    Number as Seprated By Comma)</font>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td class="bgbluegrey" colspan="2" align="Left">
                                <p align="center">
                                    <font class="blackfnt">Select
                                        <%= Session["DocketCalledAs"] %>
                                        Booking Date Range</font>
                                </p>
                            </td>
                        </tr>
                        <tr bgcolor="white" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td style="width: 210px; height: 25px;" align="Left">
                                <font class="blackfnt">Select
                                    <%= Session["DocketCalledAs"] %>
                                    Date</font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td align="center" colspan="2" style="height: 25px">
                                <asp:HiddenField ID="Hnd_BIll_Business_Type_Wise_YN" runat="server"></asp:HiddenField>
                                <asp:HiddenField ID="Hnd_BIll_POD_Approval_YN" runat="server"></asp:HiddenField>
                                <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="blackfnt" OnClick="Button1_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
<%--</form>
</body>
</html>--%>
