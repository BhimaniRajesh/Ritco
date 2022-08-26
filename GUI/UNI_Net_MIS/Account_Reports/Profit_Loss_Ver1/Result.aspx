<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Profit_Loss_Ver1_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="JS/switchcontent.js" ></script>


<style type="text/css" >

/*Style sheet used for demo. Remove if desired*/
.handcursor{
cursor:hand;
cursor:pointer;
}

</style>


 <script language="javascript" type="text/javascript" src="JS/switchcontent.js"></script>

 <script language="javascript" type="text/javascript">
function OpenPopupWindow1(strDocketNo)
        {
         //alert(strDocketNo)
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL ="../Trail_bal/Result_GL.aspx?" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
        function OpenPopupWindow2(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../accounts_mis/ledger/result.aspx?" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
        
          function OpenPopupWindow3(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../Trail_balance/Voucherlist_trailbalance.aspx??" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
        
        
        
        </script>
        
        <script language="javascript" type="text/javascript">
// MAIN FUNCTION: new switchcontent("class name", "[optional_element_type_to_scan_for]") REQUIRED
// Call Instance.init() at the very end. REQUIRED

var bobexample=new switchcontent("switchgroup1", "div") //Limit scanning of switch contents to just "div" elements
bobexample.setStatus('<img src="http://img242.imageshack.us/img242/5553/opencq8.png" /> ', '<img src="http://img167.imageshack.us/img167/7718/closedy2.png" /> ')
bobexample.setColor('darkred', 'black')
bobexample.setPersist(true)
bobexample.collapsePrevious(true) //Only one content open at any given time
bobexample.init()
</script>
        
        
  <br />   
  <table id="Table3"  runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" >
      <tr><td></td></tr>
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 12px"><font class="blackboldfnt">Reports</font> > <a href="../../rpt_finance.aspx"><font class="blklnkund">Finace & Accounts </font></a>><font class="bluefnt"> Profit & Loss Statement  </font></td></tr>  
       <tr> 
          
        </tr>
        </table>
        <br /> <br />                                                           

     
    <table id="Table1"  runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 10px"><font class="balckfnt">Branch / Profit Center </font></td><td><asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label></td></tr>  
      <tr style="background-color: #FFFFFF"><td class="blackfnt" style="height: 10px"><font class="balckfnt">Date Range </font></td><td><asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td></tr>  
        </table>
        
        <br/>
    
       <asp:Table id="tblheadache" runat="server" CellPadding="3" CellSpacing="1" style="width:9.5in;" CssClass="boxbg">
        
        </asp:Table>
    
    <br />
    <br/>
       
    <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080" 
                                                                    align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
                                                                    <tr style="background-color: #ffffff">
                                                                        <td colspan="22" align="right" style="width: 892px; height: 23px;">
                                                                            <div align="center">
                                                                                <label style="color: #FF0000;" class="blackfnt">
                                                                                    No Record Found
                                                                                </label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    </table>
    <br />
                                                                    <table border="0" align="center" cellpadding="0" cellspacing="4" 
                                                    id="tblPageNavigation" runat="server">
                                                    
                                                    
                                                  
                                                   
                                                    </table>
                                                    <table id="Table2"   runat="server"  cellpadding="3"  cellspacing="1" style="width:5.5in;" class="boxbg">
      <tr style="background-color: #FFFFFF"><td><asp:Button ID="btnShow" runat="server" Text="XLS Download"  OnClick="btnShow_Click" Width="75px"  /></td></tr>  
 
        </table>
                 <script language="javascript" type="text/javascript">

var joeexample=new switchcontent("switchgroup2", "p") //Limit scanning of switch contents to just "p" elements
joeexample.setStatus('[open] ', '[closed] ')
joeexample.setColor('green', 'red')
joeexample.collapsePrevious(false) //Allow more than 1 content to be open simultanously
joeexample.setPersist(false)
joeexample.defaultExpanded(0,1)
joeexample.setContent(0, 'whatisjavascript.htm') //specify remote content for 1st header's content
joeexample.setContent(1, 'whatisjava.htm')  //specify remote content for 2nd header's content
joeexample.init()
</script>                                 
</asp:Content>
