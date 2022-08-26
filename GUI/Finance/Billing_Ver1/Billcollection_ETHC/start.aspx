<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="start.aspx.cs" Inherits="Finance_Billing_Billsubmission_start" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript" src="../Billing.js"></script>
       <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
        var client_name="<%=Session["Client"]%>"
        FRM_Name="ctl00_MyCPH1_"
       function OnSubmit_Submission()
        {
                        //alert("hi...")
                        //alert(document.getElementById(FRM_Name+'Cbopaybas').value)
                         if(document.getElementById(FRM_Name+'Cbopaybas').value=="")
                         {
                                        alert("Plz Select Bill Type")
                                        document.getElementById(FRM_Name+'Cbopaybas').focus();
                                        return false;
                         }
                        if(document.getElementById(FRM_Name+'txtmanualbillno').value=="" && document.getElementById(FRM_Name+'Billno').value=="")
                        {
				                if(document.getElementById(FRM_Name+'Txt_Customer').value=="")
                                {
                                        alert("Plz Enter Customer Name~Code Format")
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
        </script>
        <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
<%--</head>
<body>
    <form id="form1" runat="server">--%>
    
    <div>
     
    <table  style="width:10in" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Collection 
		   
		  </strong> </font>
   </td></tr>
      
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
   
    <tr>
    <td>
    
    
    <br />
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:85%; height: 383px;"  align="center">
         <tr class="bgbluegrey" style="height: 25px">
             <td align="center" colspan="2">
                 <strong><span style="font-size: 8pt; font-family: Verdana">Enter Bills No &nbsp;For
                     Collection</span></strong></td>
         </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;">
                 <span style="font-size: 8pt; font-family: Verdana">Bill Number</span></td>
             <td style="width: 339px; height: 25px;">
                <asp:TextBox ID="Billno" runat="server" MaxLength="50"  onchange="javascript:this.value=this.value.toUpperCase()" Columns="25"  BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>&nbsp;
                 </td>
         </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;" colspan="2">
                 <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span></td>
             
           </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;">
                 <span style="font-size: 8pt; font-family: Verdana">Manual Bill Number</span></td>
             <td style="width: 339px; height: 25px;">
                <asp:TextBox ID="txtmanualbillno" runat="server"   onchange="javascript:this.value=this.value.toUpperCase()"  MaxLength="20" Columns="20"  BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>&nbsp;
                 </td>
           </tr>
           <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px; height: 25px;" colspan="2">
                 <span style="font-size: 8pt; font-family: Verdana"><b>OR</b></span></td>
             
           </tr>
           
       <tr  class="bgbluegrey" style="height:25px">
            <td colspan="2" align="center"><font class="blackfnt"><b> Select Bills For Collection</b></font></td>
            
       </tr>
         <tr bgcolor="white" style="height: 25px">
             <td align="center" style="width: 210px">
                 <span style="font-size: 8pt; font-family: Verdana">Bill Type</span></td>
             <td style="width: 339px">
                <asp:DropDownList ID="Cbopaybas" runat="server" BorderStyle="Groove" CssClass="blackfnt">
               <%-- <asp:ListItem Value="All" Selected="true"> All</asp:ListItem>--%>
              <%--  <asp:ListItem Value="2">TBB Bill</asp:ListItem>
                <asp:ListItem Value="7">Misc. Bill</asp:ListItem>--%>
                </asp:DropDownList>
             </td>
         </tr>
       <tr bgcolor="white" style="height:25px">
            <td style="width: 210px"  align="center">
               <font class="blackfnt">
                   Enter billing party code 
                  </font>
            </td>
            <td style="width: 339px">
                <asp:TextBox ID="Txt_Customer" runat="server" Width="350"  BorderStyle="Groove" CssClass="blackfnt" onblur="javascript:Customer_Location_Blur(this,'Customer','N')"  ></asp:TextBox> <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                            <div id="Abc" runat="server" class="boxbg" />
                            <%--<atlas:AutoCompleteExtender ID="Ext1" runat="server"  DropDownPanelID="Abc" >
                              <atlas:AutoCompleteProperties TargetControlID="Txt_Customer" ServicePath="../AtlasAutoComplete.asmx" 
                                        ServiceMethod="GetCustomer" MinimumPrefixLength="1" Enabled="true" />
                              </atlas:AutoCompleteExtender>--%>
                              
                              <ajaxtoolkit:autocompleteextender id="Ext1" runat="server" enabled="True"
                                    completionlistitemcssclass="autocomplete_listItem" completionlisthighlighteditemcssclass="autocomplete_highlightedListItem"
                                    minimumprefixlength="1" servicemethod="GetCustomer" servicepath="../AtlasAutoComplete.asmx"
                                    targetcontrolid="Txt_Customer">
                                </ajaxtoolkit:autocompleteextender>
                              
                              
                              <font class="redfnt" >Plz Type Initial Character OF Customer Name </font>
           </td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td  class="bgbluegrey" colspan="2" align="center">
                <p align="center">
                    <font class="blackfnt">Select Bill Generation Date Range</font>
                </p>
            </td>
            
       </tr>
        <tr bgcolor="white" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td style="width: 210px; height: 25px;"  align="center">
                <font class="blackfnt"> Select Docket Date</font>
            </td>
             <td align="left"  >
                                            <Date:DT ID="DT" runat="server" />
            </td>
       </tr>
         <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
             <td align="center" colspan="2" style="height: 25px">
                 <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" CausesValidation="False" />
                
                 </td>
         </tr>
       </table>
       </td>
         </tr>
       </table>
    </div>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV></asp:Content>
   
   <%-- </form>
</body>
</html>--%>
