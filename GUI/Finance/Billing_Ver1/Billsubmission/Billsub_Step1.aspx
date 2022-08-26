<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Billsub_Step1.aspx.cs" Inherits="Finance_Billing_Billsubmission_Billsub_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />--%>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../Billing.js"></script>
    
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">
         var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");
     var client_name="<%=Session["Client"]%>"
		var Fromdate="<%=Fromdate%>"
		var Todate="<%=Todate%>"
		var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
		FRM_NM="ctl00_MyCPH1_"
        function CheckDocketSelection(txtbsbdt,txtbillsubto,contactno,txtdocketlist,txtdocketlist_count)
        {
                
                
                  var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
                   var dt =document.getElementById(FRM_NM+"txtbsbdt").value
				   var hdndockdt;
			      var Maxdt="01/01/2007";
			   
                 var grid=document.getElementById("ctl00_MyCPH1_dockdata");
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                  var i=0     
                  //alert("hi...1")
                  for(var b=2;b<=rows-1;b++)
                  {
                        //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_dockdata_ctl0" + b + "_";
                                hdndockdt="ctl00_MyCPH1_dockdata_ctl0" + b + "_Hnd_BgnDT" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_dockdata_ctl" + b + "_";
                                 hdndockdt="ctl00_MyCPH1_dockdata_ctl" + b + "_Hnd_BgnDT";
                            }
                           // alert("hi...11")
                           //  alert(document.getElementById(hdndockdt).value)
                            hdndockdt = document.getElementById(hdndockdt).value;           
                            if(document.getElementById(GV_FRM_NM+"chkDock").checked)
                            {
                                  
                                  Check_One="Y"
                                 var Maxdt1 =Maxdt
                				
				                 var Maxdt_dd=Maxdt1.substring(0,2)
				                 var Maxdt_mm=Maxdt1.substring(3,5)
				                 var Maxdt_yy=Maxdt1.substring(6,10)
                                    
		                         var hdndockdt1 =hdndockdt
				                 var hdndockdt_dd=hdndockdt1.substring(0,2)
				                 var hdndockdt_mm=hdndockdt1.substring(3,5)
				                 var hdndockdt_yy=hdndockdt1.substring(6,10)
            				    
				                 Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                         hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                            // alert(Maxdt1)
				                   // alert(hdndockdt1)
			                       // alert(Maxdt1)
                                if (hdndockdt1>Maxdt1)
                                {
                                Maxdt1=hdndockdt1
                                Maxdt=hdndockdt
                                }
                            }
                     }
                      
                                if (dt=="")
				                {
						                alert( "Bill Submission Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"txtbsbdt").focus();
						                return false;
				                }
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
                            var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				            var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				            var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				            FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
            				
				            var FinYear_todate_dd=FinYear_todate.substring(0,2)
				            var FinYear_todate_mm=FinYear_todate.substring(3,5)
				            var FinYear_todate_yy=FinYear_todate.substring(6,10)
				            FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
            			//alert("hi...3")
				            if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				            {
						            alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Bill Submission Date  Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						            document.getElementById(FRM_NM+"txtbsbdt").focus();
						            return false;
				            }
            				
                             Fromdate1=Maxdt1
			                 Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Bill Submission Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"txtbsbdt").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Bill Submission Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"txtbsbdt").focus();
						                return false;
				                }
				                
							
						billsubto=txtbillsubto.value	
		
						if (billsubto=="")
						{
							alert("Please Enter bill Submitted To")
							txtbillsubto.focus();
							return false;
			 
            
            if(Check_One=="N")
            {
                alert("Select atleast one Bill to Submit Bill !");
                return false;
            }
            //alert(mSelection)
            txtdocketlist_count.value=mSelection
           txtdocketlist.value=mSelectedDockets;
          // alert("hi-" + txtdocketlist_count.value)
            document.getElementById("ctl00_MyCPH1_Txt_Due_Date").disabled=false
            return true;
        }
        
    </script>

    <%--<<%--/head>
<body>
    <form id="form1" runat="server">--%>
    <div>
        <table width="1000" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10">
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width: 60%"
                        align="left">
                        <tr bgcolor="white">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Bill Submission </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Billno</font>
                            </td>
                            <td>
                                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Customer Code and Name</font>
                            </td>
                            <td>
                                <asp:Label ID="lblparty" runat="server" Width="313px" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Bill Booking Date Range </font>
                            </td>
                            <td>
                                <asp:Label ID="lbldaterange" runat="server" Width="313px" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Pay Basis</font>
                            </td>
                            <td>
                                <asp:Label ID="lblpaybas" runat="server" Width="313px" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 60%"
                        align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Update Submission Details </b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Enter Bill Submission Date</font>
                            </td>
                            <td>
                                <asp:TextBox ID="txtbsbdt" runat="server" Width="65" onblur="javascript:return ValidateDate(this);"
                                    BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtbsbdt,'anchor112','dd/MM/yyyy'); return false;"
                                    name="anchor112" id="anchor112">
                                    <img src="../../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Bill Submitted to</font>
                            </td>
                            <td>
                                <asp:TextBox ID="txtsubto" runat="server" onblur="javascript:this.value=this.value.toUpperCase()"
                                    BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Customer Billing Contact No. </font>
                            </td>
                            <td>
                                <asp:TextBox ID="txtsubcontactno" runat="server" onblur="javascript:this.value=this.value.toUpperCase()"
                                    BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr bgcolor="white">
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" style="width: 100%" align="left">
                        <tr bgcolor="white">
                            <td>
                                <br />
                                <font class="blackfnt"><b>List of Bills for which Bill Can be Submited: </b></font>
                                <br />
                                <asp:CheckBox runat="server" ID="CHk_Due_dt" CssClass="blackfnt" onclick="javascript:ADD_DueDate()"
                                    Checked="true" />
                                <font class="redfnt"><b>Click Here To Change Bill Due Date According To Party Contract
                                    Days. </b></font>
                                <br />
                                <br />
                                <asp:GridView align="left" ID="dockdata" runat="server" BorderWidth="0" HeaderStyle-CssClass="bgbluegrey"
                                    AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
                                    Width="90%" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true"
                                    CssClass="boxbg" CellPadding="2" CellSpacing="1" FooterStyle-BackColor="white"
                                    EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dockdata_SelectedIndexChanged">
                                    <Columns>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:ADD_DueDate_All_Submission()" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:CheckBox ID="chkDock" runat="server" onclick="javascript:ADD_DueDate()" />
                                                </center>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <HeaderTemplate>
                                                Billno</HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:Label CssClass="blackfnt" ID="billno" Text='<%# DataBinder.Eval(Container.DataItem,"billno") %> '
                                                        runat="server">
                                                    </asp:Label>
                                                    <asp:HiddenField ID="Hnd_BgnDT" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"bgndate") %>' />
                                                </center>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="Blackfnt" />
                                            <FooterTemplate>
                                                <center>
                                                    <asp:Label CssClass="blackfnt" ID="dktamt_final" Text='' runat="server">
                                                    </asp:Label>
                                                </center>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="manualbillno" HeaderText="Manual Billno" ItemStyle-Wrap="false"
                                            ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Bbrcdnm" HeaderText="Billing Branch" ItemStyle-Wrap="false"
                                            ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ptmsstr" HeaderText="Party Name" ItemStyle-Wrap="false"
                                            ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="paybas" HeaderText="Bill Type" ItemStyle-Wrap="false"
                                            ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BILLAMT" HeaderText="Bill Amt." ItemStyle-Wrap="false"
                                            ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="pendamt" HeaderText="Unadjusted Amount" ItemStyle-Wrap="false"
                                            ItemStyle-HorizontalAlign="Right" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <%--<asp:BoundField DataField="BGNDT" HeaderText="Generation Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
                                        <asp:BoundField DataField="bgndt" HeaderText="Bill Date" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle CssClass="blackfnt" />
                                        </asp:BoundField>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <HeaderTemplate>
                                                Due Date</HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label CssClass="blackfnt" ID="LBL_CRD_DT" Text='<%# DataBinder.Eval(Container.DataItem,"credit_day") %> '
                                                    runat="server">
                                                </asp:Label>
                                                <asp:HiddenField ID="Hnd_CRD_DT" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"credit_day") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <HeaderTemplate>
                                                Due Date</HeaderTemplate>
                                            <ItemTemplate>
                                                <center>
                                                    <asp:Label CssClass="blackfnt" ID="LBL_DUE_DT" Text='<%# DataBinder.Eval(Container.DataItem,"bduedt") %> '
                                                        runat="server">
                                                    </asp:Label>
                                                    <asp:HiddenField ID="Hnd_DUEDT" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"bduedt") %>' />
                                                    <asp:HiddenField ID="Hnd_DUEDT_Old" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"bduedt") %>' />
                                                </center>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle />
                                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                                    <HeaderStyle CssClass="bgbluegrey" />
                                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                    <FooterStyle BackColor="WHITE" />
                                </asp:GridView>
                                <br />
                                <br />
                                <p>
                                </p>
                                <p>
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="txtdocketlist" runat="server" />
                                <asp:HiddenField ID="txtdocketlist_count" runat="server" />
                                <center>
                                    <asp:Button ID="Button1" runat="server" CssClass="blackfnt" Text="Click Here to Sumit Bills"
                                        OnClick="Button1_Click" /></center>
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
