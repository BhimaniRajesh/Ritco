<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PDCCancellation.aspx.cs" Inherits="GUI_Operations_document_cancel_PDCCancellation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
 <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <%--<script type="text/javascript" language="javascript" src="../../../GUI/images/commonJs.js"></script>--%>
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
        
            function THCBlur(d)
                 {
                 
                    var txtPDC=d;
                    var txtFrom=d;
                    var txtDate=d;
                    var txtManualno=d;
                    //hidPDC
                    document.getElementById("ctl00_MyCPH1_hidPDC").value=txtPDC;
                    txtFrom=txtFrom.replace( "txtPDCNo", "lblFrom");
                    document.getElementById("ctl00_MyCPH1_hidFrom").value=txtFrom;
                    txtDate=txtDate.replace( "txtPDCNo", "lblPDCDate");
                    document.getElementById("ctl00_MyCPH1_hidDate").value=txtDate;
                    txtManualno=txtManualno.replace( "txtPDCNo", "lblManualPDCNo");
                    document.getElementById("ctl00_MyCPH1_hidManualNo").value=txtManualno;
              
                    var str="";
                    for(var i=0;i<d.length-10;i++)
                    {
                        str+=d.charAt(i);
                    }
                    
                    var txtPDCNo=document.getElementById(d);
                  
                    var PDCNo=txtPDCNo.value;
                    if(PDCNo=="")
                        return false;
                 
                   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
                   var r=tbl.rows.length;
                   
                    var findobj=false;
                    findobj=GetXMLHttpObject();
                    if(findobj)
                    {
                   
                     var strpg="CheckPDC.aspx?PDC=" + PDCNo + "&sid=" + Math.random();
                     findobj.open("GET",strpg,true);
                     findobj.onreadystatechange=function()
                         {
                          
                             if(findobj.readyState==4 && findobj.status==200)
                                {
                                    var res=findobj.responseText.split("|");
                                    if(res[0]=="false")
                                    {
                                        alert("PDC NO is not Valid... Please Enter Valid PDC No");
                                        txtPDCNo.value="";
                                        txtPDCNo.focus();
                                        return false;
                                    }
                                    if(res[0]=="true")
                                    {
                                        var thc_Date= document.getElementById("ctl00_MyCPH1_hidDate").value;
	                                    document.getElementById(thc_Date).value = res[1];
	                                    
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
						                        alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO PDC Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						                        var thc_Number= document.getElementById("ctl00_MyCPH1_hidPDC").value;
	                                            document.getElementById(thc_Number).value = "";
						                        var thc_Date= document.getElementById("ctl00_MyCPH1_hidDate").value;
	                                            document.getElementById(thc_Date).value = "";
						                        var thc_From= document.getElementById("ctl00_MyCPH1_hidFrom").value;
	                                            document.getElementById(thc_From).value = "";
	                                            var thc_manualNo1= document.getElementById("ctl00_MyCPH1_hidManualNo").value;
	                                            document.getElementById(thc_manualNo1).value = "";
						                        
						                        return false;
				                        }
				                        var thc_From= document.getElementById("ctl00_MyCPH1_hidFrom").value;
	                                    document.getElementById(thc_From).value = res[2];
	                                   
	                                    var thc_manualNo1= document.getElementById("ctl00_MyCPH1_hidManualNo").value;
	                                    document.getElementById(thc_manualNo1).value = res[3];
                                        return false;
                                    }
                                    
                                }
                         }
                         
                    findobj.send(null);
                    }
                return false;
             }
                function CheckData()
                {
                    //debugger
                    var grid=document.getElementById("ctl00_MyCPH1_grvcontrols");
                    var rows=grid.rows.length;
                    var i = 2,x = 0;
                    var PDCNo;
                    var ChkSel;
                       for(i = 2; i < rows ; i++)
                       {
                        if(i<10)
                        {
                           PDCNo=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_txtPDCNo").value;
                           ChkSel=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl0" + i + "_ChkSel").checked;
                        }
                        else
                        {
                           PDCNo=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_txtPDCNo").value;
                           ChkSel=document.getElementById("ctl00_MyCPH1_grvcontrols_ctl" + i + "_ChkSel").checked;
                         }
                         if(ChkSel == true)
                         {
                            x = 1;
                            if(PDCNo == '')
                            {
                                alert("Please Enter the PDC Number");
                                return false;
                            }
                            
                         }
                    }
                    if(x == 0)
                     {
                          alert("Please Select atleast one Row !!");
                          return false;
                      }
                    //return false;
                } 


    </script>

    <div style="width: 10in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" style="border-right: 0px; border-top: 0px;
                border-left: 0px; border-bottom: 0px" />
        </a>
    </div>
    <div style="width: 10in; text-align: center">
        <table cellspacing="1" class="boxbg" style="width: 10in; text-align: center">
            <tr class="bgbluegrey">
                <td align="center">
                    <strong>PDC Details</strong>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080"
                    width="50%">
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt" width="50%">
                            Enter No. of Rows</td>
                        <td align="left" class="blackfnt" width="50%">
                            <asp:TextBox ID="txtnorows" runat="server">5</asp:TextBox>
                            <asp:Button ID="btnrows" runat="server" OnClick="btnrows_Click" Text="Add Rows" />
                        </td>
                    </tr>
                </table>
                <br />
                <table border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080;
                    text-align: center" width="100%">
                    <tr class="bgbluegrey">
                        <td align="center" class="blackfnt">
                            PDC Detail</td>
                    </tr>
                    <tr style="background-color: #ffffff;">
                        <td align="Center" class="blackfnt">
                            <asp:GridView ID="grvcontrols" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                OnRowDataBound="grvcontrols_RowDataBound" PagerSettings-FirstPageText="[First]"
                                PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast" PagerStyle-HorizontalAlign="left"
                                Width="60%">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select">
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="White" />
                                        <HeaderStyle CssClass="blackfnt" BackColor="#D4E0E7" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="ChkSel" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PDC No">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            &nbsp;<asp:TextBox ID="txtPDCNo" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                                Enabled="true" MaxLength="50" Width="100px"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Manual PDC No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblManualPDCNo" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="PDC Date">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblPDCDate" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="From">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblFrom" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:TemplateField HeaderText="To">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="lblTo" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                </Columns>
                                <PagerStyle HorizontalAlign="Left" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td class="blackfnt" style="text-align: center">
                            <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" OnClientClick="javascript:return CheckData();"
                                Text="Submit" />
                                <asp:HiddenField ID="hidPDC" runat="server" />
                                <asp:HiddenField ID="hidFrom" runat="server" />
                                
                                <asp:HiddenField ID="hidDate" runat="server" />
                                <asp:HiddenField ID="hidManualNo" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
