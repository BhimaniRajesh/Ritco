<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PDCPrint.aspx.cs" Inherits="GUI_Print_PDCPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>PRS/DRS Print</title>
    <link href="../images/style.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"     codebase="http://202.87.45.77/webx/dosprint/print_utility/ecfy_dos_print.cab#version=1,0,0,0"></object>
<form id="form1" runat="server">
<div>
     <table border="1" cellspacing="1" cellpadding="1" class="boxbg" width="100%">
                
            <tr bgcolor="#FFFFFF">
            		
                  <td width="60%" valign="top"> <font class="blackfnt"> <font size="3"><b></b></font>
                        <font class="blackfnt"><font size="3"><img border="0" src="../images/webxpress_logo.gif" alt="" /></font></font></font> 
                  </td>
            		
		            <td>
			            <table border="0" cellspacing="1" cellpadding="1" class="boxbg" width="100%">
				            <tr bgcolor="#FFFFFF">
					            <td width="50%">
						            <font class="blackfnt">PRS No.</font>
					            </td>

					            <td width="50%">
						            <font class="blackfnt"><b>
                                        <asp:Label ID="lblDrsNo" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
				            </tr>

				            <tr bgcolor="#FFFFFF">
					            <td width="50%">
						            <font class="blackfnt">PRS Date.</font>
					            </td>

					            <td width="50%">
						            <font class="blackfnt"><b>
                                        <asp:Label ID="lblDrsDate" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
				            </tr>
            				
				            <tr bgcolor="#FFFFFF">
					            <td width="50%">
						            <font class="blackfnt">Manual PRS No.</font>
					            </td>

            					
                                <td width="50%"> <font class="blackfnt"><b></b></font> <font class="blackfnt"><b>
                                    <asp:Label ID="lblManualDrsNo" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
				            </tr>

			            </table>
		            </td>
	            </tr>
	            
	            <tr bgcolor="#FFFFFF">
		            <td colspan="2">
			            <font class="blackfnt">
				            &nbsp;
			            </font>
		            </td>
	            </tr>	

	           
	            <tr bgcolor="#FFFFFF">
		            <td colspan="2" align="center" valign="top">
			            <font class="blackfnt"><font size="3">
				            <b class="blackfnt">Pickup Run Sheet
				            </b>
			            </font>
			            </font>
		            </td>
	            </tr>	

	           
	            <tr bgcolor="#FFFFFF">
		            <td colspan="2" align="center">
			            <font class="blackfnt">
				            <b class="blackfnt">Pickup Summary
				            </b>
			            </font>
		            </td>
	            </tr>	
            </table>

            <br />

            <table border="1" cellspacing="1" cellpadding="1" class="boxbg" width="100%">
                
                <tr bgcolor="#FFFFFF"> 
                  <td width="10%" align="left"> <font class="blackfnt"><b> Run Sheet Location</b></font> </td>
                  <td width="10%" align="left"> <font class="blackfnt">
                      <asp:Label ID="lblRunSheetLoc" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                  <td  colspan="4"  align="left"> <font class="blackfnt">&nbsp;</font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td width="10%" align="left"> <font class="blackfnt"><b> BA / Vendor </b></font></td>
                  <td width="23%" align="left"> <font class="blackfnt">
                      <asp:Label ID="lblBaVendor" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                  <td width="10%" align="left"> <font class="blackfnt"><b> Vehicle No.</b></font></td>
                  <td align="left"> <font class="blackfnt">
                      <asp:Label ID="lblVhclNo" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                  <td align="left"> <font class="blackfnt"><b> Driver Name</b></font></td>
                  <td align="left"> <font class="blackfnt">
                      <asp:Label ID="lblDriverNm" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
                
                <tr bgcolor="#FFFFFF"> 
                  <td width="10%" align="left" style="height: 19px"> <font class="blackfnt"><b> Starting KM </b></font></td>
                  <td width="23%" align="left" style="height: 19px"> <font class="blackfnt">
                      <asp:Label ID="lblStartingKM" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                  <td width="10%" align="left" style="height: 19px"> <font class="blackfnt"><b> Ending KM </b></font></td>
                  <td width="23%" align="left" style="height: 19px"> <font class="blackfnt">
                      <asp:Label ID="lblEndingKM" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                  <td width="14%" align="left" style="height: 19px"> <font class="blackfnt"><b> Distance Traveled</b></font></td>
                  <td width="20%" align="left" style="height: 19px"> <font class="blackfnt">
                      <asp:Label ID="lblDistance" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
              </table>

            <br/>

              <table border="1" cellspacing="1" cellpadding="1" class="boxbg" width="100%">
                
                <%--<tr bgcolor="#FFFFFF">
		            <td width="3%" align="left">
			            <font class="blackfnt">
				            Sr.<br />No.
			            </font>
		            </td>
		            <td align="left">
			            <font class="blackfnt">
				            Docket No./<br />Pay Basis
			            </font>
		            </td>

		            <td align="left">
			            <font class="blackfnt">
				            Docket Dt.
			            </font>
		            </td>


		            <td align="left">
			            <font class="blackfnt">
				            Bkg.<br />Loc.
			            </font>
		            </td>
		            <td align="left">
			            <font class="blackfnt">
				            Dely.<br/>Loc.
			            </font>
		            </td>

		            <td align="left" width="15%">
			            <font class="blackfnt">
				            C'nee/<br />Bill Party
			            </font>
		            </td>
            		
		            <td align="right">
			            <font class="blackfnt">
				            Pkgs.
			            </font>
		            </td>
		            <td align="right">
			            <font class="blackfnt">
				            Act. Wt.
			            </font>
		            </td>
		            <td align="right">
			            <font class="blackfnt">
				            Frt. Amount
			            </font>
		            </td>
            		
		            <td align="left">
			            <font class="blackfnt">
				            Trans.<br/>Mode
			            </font>
		            </td>
            		
		            <td align="left">
			            <font class="blackfnt">
				            Sign &amp; Stamp
			            </font>
		            </td>
            		
	            </tr>--%>
	            
	            <tr bgcolor="#FFFFFF">
	                <td colspan="11" style="height: 4px">
	                    <label class="blackfnt">
	                        <%=strRemainData %>            
	                    </label>
	                </td>
	            </tr>
	            
	            <tr bgcolor="#FFFFFF">
	                <%=strCal %>
	            </tr>	
            	
            </table>

            <br/>

              <table border="1" cellspacing="1" cellpadding="1" class="boxbg" width="100%">
                
                <tr bgcolor="#FFFFFF">
		            <td width="25%" align="left">
			            <font class="blackfnt">
				            &nbsp;
			            </font>
		            </td>

		            <td width="25%" align="left">
			            <font class="blackfnt">
				            &nbsp;
			            </font>
		            </td>

		            <td width="20%" align="center">
			            <font class="blackfnt">
                            <asp:Label ID="lblPreparedBy" runat="server" CssClass="blackfnt"></asp:Label></font></td>

		            <td width="10%" align="center">
			            <font class="blackfnt">
                            <asp:Label ID="lblAt" runat="server" CssClass="blackfnt"></asp:Label></font></td>

		            <td width="20%" align="center">
			            <font class="blackfnt">
                            <asp:Label ID="lblDateTime" runat="server" CssClass="blackfnt"></asp:Label></font></td>
	            </tr>

	            
	            <tr bgcolor="#FFFFFF">
		            <td width="25%" align="center">
			            <font class="blackfnt">
				            Staff Name
			            </font>
		            </td>

		            <td width="25%" align="center">
			            <font class="blackfnt">
				            Sign
			            </font>
		            </td>

		            <td width="20%" align="center">
			            <font class="blackfnt">
				            Prepared By
			            </font>
		            </td>

		            <td width="10%" align="center">
			            <font class="blackfnt">
				            At
			            </font>
		            </td>

		            <td width="20%" align="center">
			            <font class="blackfnt">
				            Date &amp; Time
			            </font>
		            </td>
	            </tr>
            </table>
            <br/>

            <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr> 
	            <td colspan="10" align="right">
            		
	            </td>
            </tr>
       </table>

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td colspan="10" align="right">
                            <input type="button" id="btnPrint" value="Print" runat="server" />
                        </td>
                    </tr>
                </table>
</div>
</form>
 <script language="javascript" type="text/javascript">
PDC_Detail="<%=PDC_Detail%>"
alert(PDC_Detail)
		<%
		Response.Write(PDC_Detail);
		%>
			window.close();
		</script>
</body>
</html>
