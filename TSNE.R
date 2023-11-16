library(readxl)
library(Rtsne)
library(ggplot2)
library(dplyr)
data<-read_excel('data_for_LASSO.xlsx',sheet = 3)
data<-as.data.frame(data)
data<-data[-2]
data<-as.data.frame(data)
N<-length(colnames(data))
data[,2:N]<-log10(data[,2:N])

#data<-data[c(1:46,80:125),]

tsne_out<-Rtsne(data[-1],perplexity=10)
pdat <- data.frame(tsne_out$Y,data$Cancer_Type)
colnames(pdat)<-c('Y1','Y2','group')
#得到每个聚类的中心位置（对横纵坐标分别求均值，方便书写聚类标签）
pdat %>% group_by(group) %>% summarise(mean_y1=mean(Y1),mean_y2=mean(Y2)) -> pdat_mean
pdat_mean <- as.data.frame(pdat_mean)
#不加图例
p<-ggplot(pdat,aes(Y1,Y2,colour=factor(group)))+
  geom_point()+scale_colour_manual(values = c('#1B9E77','orange'))+
  geom_text(data=pdat_mean,aes(x=mean_y1,y=mean_y2,label=group),colour=c('#1B9E77','orange'),size=3)+
  theme(legend.position = 'none',panel.background = element_rect(colour = "white"))
tiff(filename = "t-SNE-FS-TONFH-NC.tif",width = 10,height = 10,units ="cm",compression="lzw",bg="white",res=300)
print(p)
dev.off()