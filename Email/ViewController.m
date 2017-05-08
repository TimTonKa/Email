//
//  ViewController.m
//  Email
//
//  Created by 1134 on 2017/4/28.
//  Copyright © 2017年 1134. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sendEmailBtnPressed:(id)sender {
    
    //Method 1
/*    NSString *mailPerson = @"tim@gomaji.com";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:\%@",mailPerson]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }   */
    
    //Method 2
    MFMailComposeViewController *mailVC = [[MFMailComposeViewController alloc] init];
    mailVC.mailComposeDelegate = self;
    
    NSString *title = @"你好，寄mail是嗎？";
    NSString *content = @"如果要找廁所的話請往右手邊走到底左轉";
    NSString *linkURL = @"https://www.google.com";
    NSArray *recipients = nil;
    NSString *emailBody = [NSString stringWithFormat:@"<p>%@<p><a href='%@'>%@</a>",content,linkURL,linkURL];
    
    [mailVC setSubject:title];
    [mailVC setToRecipients:recipients];
    [mailVC setMessageBody:emailBody isHTML:true];
    [self presentViewController:mailVC animated:true completion:nil];
    /* 用MFMailComposeViewController 無法用模擬器，需要用實機才能發送
     * setSubject //主题
     * setToRecipients //收件人
     * setCcRecipients //抄送
     * setBccRecipients //密送
     * setMessageBody(body: String, isHTML: Boll) //内容
     * addAttachmentData(fileData, mimeType: "如image/jpeg", fileName: String) //附件
    */
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
