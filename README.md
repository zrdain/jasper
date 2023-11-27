# JasperHealthSample
 Sample App For Jasper

Assumptions:
- Firebase would recognize the same device and regulate the login
- One couldn't commit a weight with two timestamps of the same time
- It's stored using user id followed by timestamp millis followed by weight (String/Double). I get the information using userId

Issues:
- When you login anonymous sometimes you may get a different user id causing the user to lose their logs. This can be remedied by linking them or using email/pass instead of login
- I didn't get to populate the details page. This is a simple issue though and could be remedied easily if I had more time
- Skill issues haha. Not super familiar with Flutter so lots of learning, lots of inconsistencies in samples and throughout the web, lots of learning for Firebase/Firestore as well but Flutter implements it way easier than Kotlin/Android

Notes:
- I tried to implement it how I saw structure implemented on other Flutter apps. I've never written one from scratch so I hope it's what you want. I'm open to feedback or learning more
