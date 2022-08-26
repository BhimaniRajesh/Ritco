<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewPrintSuppbill.aspx.cs" Inherits="GUI_UNI_MIS_MR_Summary_MR_Summ_Popup" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
        
<head runat="server" >
    <title>Untitled Page</title>    
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
    <%--<script language ="javascript" type="textjavascript">window.onload = window.print()</script>--%>

</head>
<body ><center>
    <form id="form1" runat="server">
    <div>
    <% 
    
        string strGenerateBillNo = Request.QueryString.Get("billno");
        string[] Split = strGenerateBillNo.Split(new Char[] { ',' });
        string GenerateBillNo = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        string boxbg = "boxbg";
        string bgbluegrey = "bgbluegrey";
        string strborder = "border='0'";
              if (print_yn == "1")
              {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "border='1'";
                  
      %>
      <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
      </script>
                  
      
        
      <%
          }            
      %>
      
    </div>
    <div><font face=verdana size=3><b><br />
    </b></font><br />
        <br />
          <table border="0" width="900" align="left">
          <tr><td>
         <table border="0"  cellspacing="1" cellpadding="2"  width="90%" >
            <tr  bgcolor="white">
            <td colspan="4" align="left" class="blackfnt">
               <img id="imgLogo"  runat="server" height="50" width="100"  /> </td>
            </tr>
       </table>
       </td></tr>
        <tr><td>
        <table border="1" cellspacing="1" cellpadding="2" width="90%" class = <%=boxbg%> style="background-color: #8ba0e5">
       
       
        <tr class="<%=bgbluegrey%>">
            <td colspan="4" align="center" class="blackfnt">
                <label id="lblParameter" class="blackfnt">
                  <b>Supplimentary Bill Summary</b>  </label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left">
                <label id="lblCustCode" class="blackfnt">
                    Bill No</label></td>
            <td align="left">
                <asp:Label ID="lblBillno" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td align="left" style="width: 85px" class="blackfnt">
                Manual Bill No</td>
             <td align="left" class="blackfnt"><%=ManualBillno%></td>
           
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left">
                <label id="lblCustName" class="blackfnt">
                    From Date</label></td>
            <td align="left" class="blackfnt"><%=FromDt%>                        
                    </td>
            
            <td align="left" class="blackfnt">
                To Date</td>
            <td align="left" class="blackfnt"><%=ToDt%></td>
            
        </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt" style="height: 20px">Bill Date</td>
                <td align="left" class="blackfnt" style="height: 20px"><%=BillDt%></td>
                <td align="left" class="blackfnt" style="height: 20px">Due Date</td>
                <td align="left" class="blackfnt" style="height: 20px"><%=DueDt%></td>
                
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Party</td>
                <td align="left" class="blackfnt"><%=partyno%></td>
                <td align="left" class="blackfnt" style="height: 20px">
                    Aggrement Number</td>
                <td align="left" class="blackfnt" style="height: 20px"><%=AggrementNo%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt" style="height: 20px">
                    Bill Sub. Branch</td>
               <td align="left" class="blackfnt" style="height: 20px"><%=billsubbrcd%></td>
                <td align="left" class="blackfnt" style="height: 20px">
                    Bill Coll. Branch</td>
                <td align="left" class="blackfnt" style="height: 20px"><%=billcolbrcd%></td>
            </tr>
            <%--<tr style="background-color: #ffffff">
                <td align="left" class="blackfnt" style="height: 20px">
                    Prepared At</td>
               <td align="left" class="blackfnt" style="height: 20px"><%=PreparedAt%></td>
                <td align="left" class="blackfnt" style="height: 20px">
                    Prepared By</td>
                <td align="left" class="blackfnt" style="height: 20px"><%=PreparedBy%></td>
            </tr>--%>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt" style="height: 20px">
                    Narration</td>
               <td align="left" class="blackfnt" style="height: 20px"><%=billmstNarration%></td>
                <td align="left" class="blackfnt" style="height: 20px">
                    Document Name & Number</td>
                <td align="left" class="blackfnt" style="height: 20px"><%=docdetail%></td>
            </tr>
    </table>
         </td></tr>
        <tr><td>
        <table border="<%=strborder%>" cellspacing="1" cellpadding="2" width="90%" class = <%=boxbg%> style="background-color: #8ba0e5">
            <tr class="<%=bgbluegrey%>">
                <td colspan="4" align="center" style="height: 20px" class="blackfnt">
                    <label id="Label5" class="blackfnt">
                        Bill Account & Charage Details</label></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td colspan="4">
                    <table border="<%=strborder%>" cellpadding="1" width="100%" bgcolor="#808080" cellspacing="0" class=boxbg>
                        <tr class="<%=bgbluegrey%>"> 
                            <td align="center" class="blackfnt" width="40%">Account</td>
                            <td align="center" class="blackfnt" width="20%">Amount</td>
                            <td align="center" class="blackfnt" width="40%">Narration</td>
                        </tr>
                    </table>
                </td>
              </tr>
            <tr style="background-color: #ffffff">
                <td colspan="4">
                    <asp:Repeater ID="Repeater2" runat="server">
                        <ItemTemplate>
                            <table border="1" cellpadding="3" width="100%" bgcolor="#808080" cellspacing="0" class=boxbg>
                                <tr bgcolor="white"> 
                                    <td align="center" width="40%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "Account")%></font></td>
                                    <td align="right" width="20%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "totamt")%></font></td>
                                    <td align="center" width="40%"><font class=blackfnt><%#DataBinder.Eval(Container.DataItem, "billdetNarration")%></font></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:Repeater>
                </td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt" width="40%">
                 <B>Sub Total</B></td>
                <td align="right" class="blackfnt" width="20%"><%=Subtot%></td>
                <td align="right" class="blackfnt" colspan="2"></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                   Service Tax</td>
                <td align="right" class="blackfnt"><%=servicetax%></td>
                <td align="right" class="blackfnt" colspan="2"></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Cess</td>
                <td align="right" class="blackfnt" ><%=cesstax%></td>
                <td align="right" class="blackfnt" colspan="2"></td>
            </tr>            
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                   HIgher Edu.Cess</td>
                <td align="right" class="blackfnt"><%=hedu_cess%></td>
                <td align="right" class="blackfnt" colspan="2"></td>
                <%--<td colspan="2" class="blackfnt"></td>--%>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    <b>Total</b></td>
                <td align="right" class="blackfnt"><%=total%></td>
                <td align="right" class="blackfnt" colspan="2"></td>
            </tr>
            <%--<tr style="background-color: #ffffff"  visible="false">
                <td align="left" class="blackfnt">
                    Payment Mode</td>
                <td align="left" class="blackfnt">
                    </td>
                <td align="left" class="blackfnt">
                </td>
                <td align="left" class="blackfnt"><%=PayMode%></td>
            </tr>--%>
        </table>
          </td></tr>
        </table>
    </div>
    </form>
    </center>
     <br />
	
</body>
</html>
