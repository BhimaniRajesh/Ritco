<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Goods_RCPT_3.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    

function ch()
{
// debugger
  
  var grid=document.getElementById("ctl00_MyCPH1_GV_Booking");
  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_Booking"
  var arrstr="";
  var q ="n";
  for(var b=2;b<=rows;b++)
  {
        var c="";
          var bl="";
        var dt="";
        
        if(b<10)
        {
            c="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_chksrno";
                  bl="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_txtbill";
            dt="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_txtdt";
            
        }
        else
        {
        
        
        
        c="ctl00_MyCPH1_GV_Booking_ctl" + b + "_chksrno";
                 bl="ctl00_MyCPH1_GV_Booking_ctl" + b + "_txtbill";
            dt="ctl00_MyCPH1_GV_Booking_ctl" + b + "_txtdt";
         
            
        }
        
 
        var tb1=document.getElementById(c);
      
        var bl1=document.getElementById(bl);
        var dt1=document.getElementById(dt);
        
        
 
  
      if(tb1.checked == true)
        {
            q="y"
           
            if(bl1.value=="")
            {
                alert("Bill No Can not ne Blanck....")
                bl1.focus();
                return false;
            }
            
             
            
            if(dt1.value=="")
            {
                alert("Date Can not ne Blanck....")
                dt1.focus();
                return false;
            }
            if(!isValidDate(dt1.value,"Vendor Bill"))
            {
                return false;
            }
            
            
           
 
            
              
            
            //return true;
        }
         
        

   } // END OF for

       if(q == "n")
        {
            alert("Please Select Atleast One....")
            return false;
        }
   
     return true;
 
}



    </script>

    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="blklnkund"><b>Goods Receipts</b></font><b>&gt;
                            </b><font class="bluefnt"><b>List of Pending PO </b></font>
                </td>
            </tr>
        </table>
       
       
       <br /><br /><br />
       
       <asp:Panel ID="plnerr" Visible="false" runat="server">
            <table width="90%">
                <tr>
                    <td align="center">
<asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
<br />
<asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
 <br />
                    <br />
                    <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
               
                    </td>
                </tr>
            </table>
        </asp:Panel>
        
        <asp:Panel ID="pnl1" runat="server">
            <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2"
                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                OnPageIndexChanging="pgChange" AllowSorting="false" AutoGenerateColumns="false"
                ShowFooter="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found...">
                <PagerStyle VerticalAlign="Bottom" />
                <Columns>
                    <asp:TemplateField HeaderText="SR.NO.">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                        <ItemStyle CssClass="blackfnt" Width="50" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                            <asp:CheckBox ID="chksrno" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="pocode" ItemStyle-Wrap="true" HeaderText="PO Code" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="podt" ItemStyle-Wrap="true" HeaderText="PO Date" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="assetcd" ItemStyle-Wrap="true" HeaderText="Asset Code"
                        HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="assetnm" ItemStyle-Wrap="true" HeaderText="Asset Name"
                        HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="narration" ItemStyle-Wrap="true" HeaderText="Description"
                        HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="qty" ItemStyle-Wrap="true" HeaderText="Qty" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="rate" ItemStyle-Wrap="true" HeaderText="Rate" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="total" ItemStyle-Wrap="true" HeaderText="Total" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="ven" ItemStyle-Wrap="true" HeaderText="Vendor" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Vendor Bill No" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:TextBox ID="txtbill" Width="110" runat="server" BorderStyle="Groove"></asp:TextBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Vendor Bill Date (dd/mm/yyyy)" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:TextBox ID="txtdt" Width="100" runat="server" BorderStyle="Groove"></asp:TextBox><%--<a href="#" onclick="cal.select(ctl00$MyCPH1$txtdt,'anchor3','dd/MM/yyyy'); return false;" name="anchor3" id="a3">
                        <img src="./../../images/calendar.jpg" border="0"></img>--%>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
                <tr align="center">
                    <td style="background-color: #ffffff">
                        <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                        </asp:LinkButton>
                    </td>
                    <td style="background-color: #ffffff">
                        <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                        </asp:LinkButton>
                    </td>
                </tr>
                <tr align="center">
                </tr>
                <tr bgcolor="white">
                    <td colspan="2" align="center">
                        <asp:Button ID="btn_csv" Text="Submit" runat="server" Width="170" OnClick="btn_csv_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
