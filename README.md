# SLoCUST

## Sub-Linear Complexity UI System Template

SLoCUST, or Slocust, is an example of my methodology for doing dynamic client-server in a way that takes minimal setup, and can scale massively, while costing sub-linear amounts of effort to set up new UI.

I have often read complaints about how the Web is a ghetto compared to traditional rich GUI libraries, which I have found to be exactly the opposite for myself.  I have worked with traditional GUI libraries for over 20 years and have found them very difficult to get initially set up, and even more difficult to change once they are set up, and very limited in terms of how much depth and breadth can be added to them.  

Frequently early decisions limit the amount of UI that can actually be created later, as the data structures are simply not available or cannot be connected with a reasonable amount of work to existing UI.

In contrast, the methodology I have been using through browsers (HTML/JS on the Client, with the majority of dynamic generation on the server) has been scaling excellently for me for the past 10 years (now 2015), and I would say is "infinitely" scalable with a "sub-linear" amount of effort and complexity, which means that as you add more UI to an application it takes less time than it did the first time for additional components.

The goal of efficiency should be to create logarithmic functions, but this takes many efficiencies to create, and may ultimately be impossible and require an "M*log(N)" algorithm at best.  Still, sub-linear is a great efficiency over the N^2 and above type complexities I have found in working with traditional GUI libraries and frameworks.

