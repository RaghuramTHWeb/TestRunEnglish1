
*** Settings ***
Library           OperatingSystem
Library           String
Library           Collections
Library           SMTP

*** Variables ***
${SMTP_SERVER}    smtp.example.com
${SMTP_PORT}      587
${SENDER_EMAIL}   your_email@example.com
${RECIPIENT_EMAIL} recipient_email@example.com
${EMAIL_SUBJECT}  PyCharm Report
${EMAIL_BODY}     Please find the attached PyCharm report.
${REPORT_PATH}    C:/Users/Lenovo/PycharmProjects/Tests/reports/report.html

*** Test Cases ***
Send PyCharm Report Via Email
    ${email_body}=    Set Variable    ${EMAIL_BODY}
    ${email_subject}=    Set Variable    ${EMAIL_SUBJECT}
    ${report_path}=    Set Variable    ${REPORT_PATH}
    Send Email    ${SENDER_EMAIL}    ${RECIPIENT_EMAIL}    ${email_subject}    ${email_body}    ${report_path}

*** Keywords ***
Send Email
    [Arguments]    ${sender_email}    ${recipient_email}    ${subject}    ${body}    ${attachment_path}
    ${smtp}=    Connect To SMTP    ${SMTP_SERVER}    ${SMTP_PORT}
    ${message}=    Create Email Message    ${sender_email}    ${recipient_email}    ${subject}    ${body}    ${attachment_path}
    Send Message    ${smtp}    ${message}
    Close Connection    ${smtp}

Create Email Message
    [Arguments]    ${from}    ${to}    ${subject}    ${body}    ${attachment_path}
    ${message}=    Create Object    email.mime.multipart.MIMEMultipart
    ${message}.add_header    From: ${from}
    ${message}.add_header    To: ${to}
    ${message}.add_header    Subject: ${subject}
    ${message}.attach    Create Object    email.mime.text.MIMEText    ${body}
    ${attachment}=    Create Object    email.mime.base.MIMEBase    application    octet-stream
    ${attachment}.set_payload    Read File    ${attachment_path}
    ${attachment}.add_header    Content-Disposition: attachment; filename=report.html
    ${message}.attach    ${attachment}
    [Return]    ${message}

Read File
    [Arguments]    ${file_path}
    ${file}=    Open File    ${file_path}
    ${content}=    Read    ${file}
    Close File    ${file}
    [Return]    ${content}
