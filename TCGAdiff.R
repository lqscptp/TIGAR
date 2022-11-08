

#install.packages("ggpubr")


library(ggpubr)                   #引用ggpubr包
inputFile="TIGAR.txt"     #输入文件
outFile="TIGAR.pdf"                #输出文件
setwd("D:\\biowolf\\geneMeta\\06.TCGAdiff")     #设置工作目录

#读取输入文件，并对输入文件整理
rt=read.table(inputFile, header=T, sep="\t", check.names=F)
gene=colnames(rt)[2]
colnames(rt)=c("id", "Expression", "Type")

#设置比较组
group=levels(factor(rt$Type))
rt$Type=factor(rt$Type, levels=group)
comp=combn(group,2)
my_comparisons=list()
for(i in 1:ncol(comp)){my_comparisons[[i]]<-comp[,i]}

#绘制boxplot
boxplot=ggboxplot(rt, x="Type", y="Expression", color="Type",
		          xlab="",
		          ylab=paste0(gene, " expression"),
		          legend.title="Type",
		          palette = c("blue", "red"),
		          add = "jitter")+ 
	    stat_compare_means(comparisons = my_comparisons)

#输出图片
pdf(file=outFile,width=5,height=4.5)
print(boxplot)
dev.off()


