<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossingChallanCancellation.aspx.cs" Inherits="GUI_Operations_Crossing_Exception_CrossingChallanCancellation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
        
        frm_name="ctl00$MyCPH1$"
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
		
        Frmnae="ctl00$MyCPH1$"
        
            function ChallanData(d)
                 {
                 
                    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");                
                    hdnajaxstate.value="1";
                    var txtChallanNo=d;
                    var txtLocation=d;
                    var txtDate=d;
                    var txtVendor=d;
                    var txtTopay=d;
                    var txtCrossing=d;
                    var txtDDChrg=d;
                    var txtBulky=d;
                    var txtNetAmt=d;
                    
                   //txtLocation,txtDate,txtVendor,txtTopay,txtCrossing,txtDDChrg,txtBulky,txtNetAmt
                    document.getElementById("ctl00_MyCPH1_hidChallan").value=txtChallanNo;
                    txtLocation=txtLocation.replace( "txtChallanNo", "txtLocation");
                    txtDate=txtDate.replace( "txtChallanNo", "txtDate");
                    document.getElementById("ctl00_MyCPH1_hidDate").value=txtDate;
                    txtVendor=txtVendor.replace( "txtChallanNo", "txtVendor");
                    txtTopay=txtTopay.replace( "txtChallanNo", "txtTopay");
                    txtCrossing=txtCrossing.replace( "txtChallanNo", "txtCrossing");
                    txtDDChrg=txtDDChrg.replace( "txtChallanNo", "txtDDChrg");
                    txtBulky=txtBulky.replace( "txtChallanNo", "txtBulky");
                    txtNetAmt=txtNetAmt.replace( "txtChallanNo", "txtNetAmt");
                          
                    var str="";
                    for(var i=0;i<d.length-10;i++)
                    {
                        str+=d.charAt(i);
                    }
                    
                    var txtChallanNo=document.getElementById(d);
                  
                    var ChallanNo=txtChallanNo.value;
                    if(ChallanNo=="")
                        return false;
                 
                   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
                   var r=tbl.rows.length;
                   
                    var findobj=false;
                    findobj=GetXMLHttpObject();
                    if(findobj)
                    {
                     //debugger;
                     var strpg="CheckExist.aspx?ChallanNo=" + ChallanNo + "&sid=" + Math.random();
                     findobj.open("GET",strpg,true);
                     findobj.onreadystatechange=function()
                         {
//                         alert(findobj.readyState)
//                         alert(findobj.status)
                             if(findobj.readyState==4 && findobj.status==200)
                                {
                                    var res=findobj.responseText.split('|');
                                    if(res[0]=="false")
                                    {   
                                        txtChallanNo.value="";
                                        txtChallanNo.focus();
                                        hdnajaxstate.value="0";
                                        return false;
                                    }
                                    if(res[0]=="true")
                                    {
                                        var challan_Date= document.getElementById("ctl00_MyCPH1_hidDate").value;
	                                    document.getElementById(challan_Date).value = res[1];
	                                    Frmnae="ctl00$MyCPH1$"
                                        var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
	                                    var dt =res[1]
				
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
						                        alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO THC Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
//						                        var thc_Number= document.getElementById("ctl00_MyCPH1_hidTHC").value;
//	                                            document.getElementById(thc_Number).value = "";
//						                        var thc_Date= document.getElementById("ctl00_MyCPH1_hidDate").value;
//	                                            document.getElementById(thc_Date).value = "";
//						                        var thc_From= document.getElementById("ctl00_MyCPH1_hidFrom").value;
//	                                            document.getElementById(thc_From).value = "";
//	                                            var thc_To= document.getElementById("ctl00_MyCPH1_hidTo").value;
//	                                            document.getElementById(thc_To).value = "";
//	                                            var thc_manualNo1= document.getElementById("ctl00_MyCPH1_hidManualNo").value;
//	                                            document.getElementById(thc_manualNo1).value = "";
						                        return false;
				                        }
				                        //alert(res[1]);
				                        document.getElementById(txtDate).value = res[1];
	                                    document.getElementById(txtLocation).value = res[2];
	                                    document.getElementById(txtVendor).value = res[3];
	                                    document.getElementById(txtTopay).value = res[4];
	                                    document.getElementById(txtCrossing).value = res[5];
	                                    document.getElementById(txtDDChrg).value = res[6];
	                                    document.getElementById(txtBulky).value = res[7];
	                                    document.getElementById(txtNetAmt).value = res[8];
	                                    hdnajaxstate.value="1";
                                        return false;
                                    }
                                    
                                }
                         }
                    }     
                    findobj.send(null);
                    
                //return false;
             }
                function CheckData()
                {                    
                    //debugger;
                    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");                
//                    if(hdnajaxstate.value!="0")
//                    {
//                        alert("Let the Internal Processes over. Try After 5-10 seconds or LogOut.");
//                        return false;
//                    }
                    var grid=document.getElementById("ctl00_MyCPH1_grvcontrols");
                    var rows=grid.rows.length;
                    var i = 2,x = 0;
                    var ChallanNo;
                    var ChkSel;
                       for(i = 2; i < rows ; i++)
                       {
                        if(i<10)
                        {
                           ChallanNo=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtChallanNo").value;
                           ChkSel=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_ChkSel").checked;
                        }
                        else
                         {
                           ChallanNo=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtChallanNo").value;
                           ChkSel=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_ChkSel").checked;
                         }
                         if(ChkSel == true)
                         {
                            x = 1;
                            if(ChallanNo == '')
                            {
                                alert("Please Enter the Challan Number");
                                return false;
                            }
                            
                         }
                         
                    }
                    
                    if(x == 0)
                      {
                          alert("Please Select atleast one Row !!");
                          return false;
                      }
                      return true;
                } 
    </script>
    <br />
    <div style="width: 7in; text-align: left">
        <table cellspacing="1" class="boxbg" style="width: 9.0in; text-align: left">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>Crossing Challan Detail</strong>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:  9.0in">
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt" width="50%">
                            Enter No. of Rows</td>
                        <td align="left" class="blackfnt" width="50%">
                            <asp:TextBox ID="txtnorows" runat="server" BorderStyle="Groove">5</asp:TextBox>
                            <asp:Button ID="btnrows" runat="server" OnClick="btnrows_Click" BorderStyle="Groove"
                                Text="Add Rows" />
                        </td>
                    </tr>
                </table>
                <br />
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:  9.0in">
                    <tr class="bgbluegrey">
                        <td align="center" class="blackfnt">
                            <b>Challan Detail</b></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="Center" class="blackfnt">
                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" EmptyDataText="No Records Found..."
                                FooterStyle-CssClass="boxbg" OnRowDataBound="grvcontrols_RowDataBound" PagerSettings-FirstPageText="[First]"
                                PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left"
                                Width="9.0in">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="White" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="ChkSel" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Challan No">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtChallanNo" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                                Enabled="true" MaxLength="50" Width="130px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Location">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtLocation" runat="server" BorderStyle="Groove" Width="50px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Challan Date">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDate" runat="server" BorderStyle="Groove" Width="50px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Vendor">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtVendor" runat="server" BorderStyle="Groove" Width="150px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Topay">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtTopay" runat="server" BorderStyle="Groove" Width="50px" Enabled="false" style="text-align:right"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Crossing">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtCrossing" runat="server" BorderStyle="Groove" Width="50px" Enabled="false" style="text-align:right"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Door Delivery">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDDChrg" runat="server" BorderStyle="Groove" Width="50px" Enabled="false" style="text-align:right"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Bulky">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtBulky" runat="server" BorderStyle="Groove" Width="50px" Enabled="false" style="text-align:right"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Net Amount">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtNetAmt" runat="server" BorderStyle="Groove" Width="50px" Enabled="false" style="text-align:right"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Left" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td class="blackfnt" style="text-align: center">
                            <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" BorderStyle="Groove"
                                OnClientClick="javascript:return CheckData();" Text="Submit" />
                            <asp:HiddenField ID="hidChallan" runat="server" />
                            <asp:HiddenField ID="hidFrom" runat="server" />
                            <asp:HiddenField ID="hidTo" runat="server" />
                            <asp:HiddenField ID="hidDate" runat="server" />
                            <asp:HiddenField ID="hidManualNo" runat="server" />
                            <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
