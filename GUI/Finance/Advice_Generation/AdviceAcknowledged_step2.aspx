<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdviceAcknowledged_step2.aspx.cs" Inherits="GUI_Finance_Advice_Generation_AdviceAcknowledged_step2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
    var client_name="<%=Session["Client"]%>"
	var FinYear="<%=Session["FinYear"]%>"
	var FinYear_to=parseInt(FinYear)+1
		
	if(FinYear_to<10)
	{
	FinYear_to="0"+FinYear_to
	}
	var FinYear_fromdate="01/04/"+FinYear
	var FinYear_todate="31/03/"+FinYear_to
	var Sle_finyear=FinYear+"-"+FinYear_to
	
    function check()
        {
            //debugger;
            var Frame = "ctl00$MyCPH1$dgGeneral$ctl";
            var click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);
            var tbl=document.getElementById("ctl00_MyCPH1_dgGeneral");
            var r=tbl.rows.length;
            var non=0;
            for(var i=2;i<=r;i++)
            {
                var txtAccDate,chkAdvice,dlstAcccode
                if(i<10)
                {
                    txtAccDate=document.getElementById(Frame + "0" + i + "$txtAccDate");
                    chkAdvice=document.getElementById(Frame + "0" + i + "$chkAdvice");
                    dlstAcccode=document.getElementById(Frame + "0" + i + "$dlstAcccode");
                }
                else
                {
                    txtAccDate=document.getElementById(Frame + i + "$txtAccDate");
                    chkAdvice=document.getElementById(Frame + i + "$chkAdvice");
                    dlstAcccode=document.getElementById(Frame + i + "$dlstAcccode");
                }    
                    
                var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                    
                if(chkAdvice.checked == true)
                       {     
				            non = non + 1;
				            
				            if(dlstAcccode.value=="")
				            {
				              alert("Please Plz Select The Account")
				              dlstAcccode.focus();
				              return false;
				            }
				            if(txtAccDate.value=="")
				            {
				              alert("Please enter the Receipt Date")
				              txtAccDate.focus();
				              return false;
				            }
						 
				        	var dt =txtAccDate.value
				
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
            			
				            if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				            {
						            alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Advice Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						            txtAccDate.focus();
						            return false;
				            }
                            if (dt>server_dt)
                            {
		                         alert( "Advice Receipt Date  should not be greater than today's date !!!")
		                         txtAccDate.focus();
		                         return false;
                            }
//                            if (dt < server_dt)
//                            {
//		                         alert( "Advice Receipt Date should not be less than today's date !!!")
//		                         txtAccDate.focus();
//		                         return false;
//                            }
                            
                            strAdvdt = chkAdvice.value;
                            
                            dt = txtAccDate.value
                            dt_dd=dt.substring(0,2)
	                        dt_mm=dt.substring(3,5)
	                        dt_yy=dt.substring(6,10)

                            sdt = strAdvdt
	                        sdt_dd=sdt.substring(0,2)
	                        sdt_mm=sdt.substring(3,5)
	                        sdt_yy=sdt.substring(6,10)
            				
                            dt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                            strAdvdt1 = new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
               
                            
				            if (dt < strAdvdt1)
                            {
		                            alert( "Advice Receipt Date should not be Less than Advice Generation Date " + strAdvdt + " !!!")
		                            txtAccDate.value = "";
		                            txtAccDate.focus();
		                            return false;
                            }
                       }  
                       
                }
                if(non == 0)
                {
                    alert("Plz Check Atleast One Advice No");
                    return false;
                } 
                
 				if(click_count > 0)
				{
					alert("Sorry... You cannot click twice !!!")
					return false;
				}  
				else
				{
					click_count=click_count+1
					document.getElementById("ctl00_MyCPH1_click_count").value=click_count
					return true;
				}     
        }	
</script>
<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
    <img alt="back" src="../../images/back.gif" border="0" /></a>
</div>
<div style="text-align: center; width: 10.0in">
    <br />
    <asp:UpdatePanel ID="updatepanel" runat="server">
        <ContentTemplate>
            <br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                            <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <table cellspacing="1" class="boxbg" width="800">
                <tr class="bgbluegrey">
                    <td align="center" >
                        <strong>List Of Advice Submitted</strong>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt">
                        <asp:GridView ID="dgGeneral" runat="server" AllowPaging="False" AllowSorting="False"
                        AutoGenerateColumns="False" OnRowDataBound="dgGeneral_RowDataBound" HeaderStyle-CssClass="bgbluegrey"
                        EmptyDataText="No Records Found..." EmptyDataRowStyle-CssClass="bgwhite" EmptyDataRowStyle-HorizontalAlign="Left" BorderWidth="0" 
                        RowStyle-CssClass="bgwhite" CssClass="boxbg" CellSpacing="1">
                            <Columns>
                                <asp:TemplateField HeaderText="Select">
                                    <ItemTemplate>
                                        <input type="checkbox" id="chkAdvice" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"adviceDt1") %>' />   
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AdviceNo" HeaderText="Advice No" />
                                <asp:BoundField DataField="Advicetype" HeaderText="Type"  />
                                <asp:BoundField DataField="credit_account" HeaderText="Transaction Type"  />
                                <asp:BoundField DataField="Accdesc" HeaderText="Transaction Description"  />
                                <asp:BoundField DataField="advicestatus" HeaderText="Status"   />
                                <asp:BoundField DataField="RaisedBy" HeaderText="Raised By"  />
                                <asp:BoundField DataField="Raisedon" HeaderText="Raised On"  />
                                <asp:BoundField DataField="Advice_amount" HeaderText="Amount"  />
                                <asp:BoundField DataField="adviceDt" HeaderText="Generation Date"  />
                                <asp:BoundField DataField="chqno" HeaderText="Cheque No"  />
                                <asp:BoundField ItemStyle-Wrap="false" DataField="chqdt" HeaderText="Cheque Date"  />
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Deposited In" >
                                    <ItemTemplate>
                                        <asp:DropDownList id="dlstAcccode" runat= "server"></asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Left" HeaderText="Receipt Date (dd/mm/yyyy)">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtAccDate" runat="server" MaxLength="10" cssclass="input" Width="60px"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White" visible="false" id="cmdbtnrow" runat="server"> 
                    <td class="blackfnt">
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClientClick="javascript:return check()" OnClick="cmdSubmit_Click" ValidationGroup="check" />
                        <asp:HiddenField ID="click_count" runat="server" Value="0" />
                    </td>
                </tr>    
            </table>    
            <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                        <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>    
                </ContentTemplate>
            </asp:UpdatePanel>    
            </ContentTemplate>
    </asp:UpdatePanel>
</div>	
</asp:Content>

