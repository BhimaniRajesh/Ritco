<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdvRecv_step2.aspx.cs" Inherits="GUI_finance_advice_AdvRecv_step2" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
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
            
            var tbl=document.getElementById("ctl00_MyCPH1_dgGeneral");
            var r=tbl.rows.length;
            var non=0;
            for(var i=2;i<r;i++)
            {
                var txtAccDate,chkAdvice
                if(i<10)
                    {
                        txtAccDate=document.getElementById("ctl00$MyCPH1$dgGeneral$ctl0" + i + "$txtAccDate");
                        chkAdvice=document.getElementById("ctl00$MyCPH1$dgGeneral$ctl0" + i + "$chkAdvice");
                        
                    }
                else
                    {
                        txtAccDate=document.getElementById("ctl00$MyCPH1$dgGeneral$ctl" + i + "$txtAccDate");
                        chkAdvice=document.getElementById("ctl00$MyCPH1$dgGeneral$ctl" + i + "$chkAdvice");
                        
                    }
                         //Frmnae="ctl00$MyCPH1$dgGeneral$ctl0"
                           var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
	                        //alert(document.getElementById(Frmnae+"TxtCBSDT").value)
                            // return false;
                       //debugger;
                       if(chkAdvice.checked == true)
                       {     
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
		                            alert( "Receipt Date  should not be greater than today's date !!!")
		                            txtAccDate.focus();
		                            return false;
                            }
                       }    
                }     
        }
    
</script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Advice Acknowledgement</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <br>
  <p align="center"><font class=blackfnt><b>List of Debit Advices Received </b></font><font class=blackfnt><b><br>
  <br>
      <asp:GridView ID="dgGeneral" runat="server" AllowPaging="True" AllowSorting="True"
          AutoGenerateColumns="False" OnRowDataBound="dgGeneral_RowDataBound" CssClass="blackfnt">
          <Columns>
              <asp:TemplateField HeaderText="Select">
              <ItemTemplate>
              <asp:CheckBox ID="chkAdvice" runat="server" ValidationGroup="SYS"/>
              </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="AdviceNo" HeaderText="Advice No" />
              <asp:BoundField DataField="Advicetype" HeaderText="Type"  />
              <asp:BoundField DataField="credit_account" HeaderText="Transaction Type"  />
              <asp:BoundField DataField="Accdesc" HeaderText="Transaction Description"  />
              <asp:BoundField DataField="advicestatus" HeaderText="Status"   />
              <asp:BoundField DataField="RaisedBy" HeaderText="RaisedBy"  />
              <asp:BoundField DataField="Raisedon" HeaderText="Raised On"  />
              <asp:BoundField DataField="Advice_amount" HeaderText="Amount"  />
              <asp:BoundField DataField="adviceDt" HeaderText="Generation Date"  />
              <asp:TemplateField HeaderText="Deposited In" >
              <ItemTemplate>
                <asp:DropDownList id="dlstAcccode" runat= "server" enabled="false" ></asp:DropDownList>
                 <%-- <asp:RequiredFieldValidator  ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select Account!!!" Display="Dynamic" ControlToValidate="dlstAcccode" EnableClientScript="true" ValidationGroup="nocheck"></asp:RequiredFieldValidator>--%>
              </ItemTemplate>
              </asp:TemplateField>
               <asp:TemplateField HeaderText="Receipt Date (dd/mm/yyyy)">
              <ItemTemplate>
              <asp:TextBox ID="txtAccDate" runat="server" MaxLength="10" cssclass="input" Width="60px" ValidationGroup="SYS" enabled="false" ></asp:TextBox>
              <asp:RegularExpressionValidator ID="RegularExpressionAdviceDate" runat="server"
                    ControlToValidate="txtAccDate" ErrorMessage="Please Enter Valid Date!!!" Display="Dynamic"
                    ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Date!!!" Display="Dynamic" ControlToValidate="txtAccDate"></asp:RequiredFieldValidator>
              </ItemTemplate>
              </asp:TemplateField>
          </Columns>
      </asp:GridView>
    <br />
    <asp:Button ID="cmdSubmit" runat="server" Text="Submit" OnClientClick="javascript:return check()" OnClick="cmdSubmit_Click" ValidationGroup="check" />
    <br />
</asp:Content>

