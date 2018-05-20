#Trying to make a colored bar plot for each site. 
#This is the code I have managed to write so far, but cannot figure out how to set
#y-axis to relative abundances. Can you please advise? Thanks.
#The plot shown is from the MetaPhlan class data file that you sent. 

ggplot(data = metaclass) + aes(x = V3, fill = V3) + geom_bar()