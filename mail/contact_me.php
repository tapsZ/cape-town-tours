<?php
if (empty($_POST['name'])    ||
    empty($_POST['email'])   ||
    empty($_POST['phone'])   ||
    empty($_POST['message']) ||
    !filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
    echo "No arguments Provided!";
    return false;
}

$name    = strip_tags(trim($_POST['name']));
$email   = filter_var(trim($_POST['email']), FILTER_SANITIZE_EMAIL);
$phone   = strip_tags(trim($_POST['phone']));
$message = strip_tags(trim($_POST['message']));

// Prevent email header injection by removing newlines from values used in headers
$name  = str_replace(["\r", "\n"], '', $name);
$email = str_replace(["\r", "\n"], '', $email);

$to            = 'yourname@yourdomain.com'; // TODO: replace with your real email address
$email_subject = "Website Contact Form: $name";
$email_body    = "You have received a new message from your website contact form.\n\n"
               . "Name: $name\n\nEmail: $email\n\nPhone: $phone\n\nMessage:\n$message";
$headers       = "From: noreply@yourdomain.com\r\n";
$headers      .= "Reply-To: $email";

mail($to, $email_subject, $email_body, $headers);
return true;
?>
