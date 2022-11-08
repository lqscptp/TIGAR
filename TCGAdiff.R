

#install.packages("ggpubr")


library(ggpubr)                   #����ggpubr��
inputFile="TIGAR.txt"     #�����ļ�
outFile="TIGAR.pdf"                #����ļ�
setwd("D:\\biowolf\\geneMeta\\06.TCGAdiff")     #���ù���Ŀ¼

#��ȡ�����ļ������������ļ�����
rt=read.table(inputFile, header=T, sep="\t", check.names=F)
gene=colnames(rt)[2]
colnames(rt)=c("id", "Expression", "Type")

#���ñȽ���
group=levels(factor(rt$Type))
rt$Type=factor(rt$Type, levels=group)
comp=combn(group,2)
my_comparisons=list()
for(i in 1:ncol(comp)){my_comparisons[[i]]<-comp[,i]}

#����boxplot
boxplot=ggboxplot(rt, x="Type", y="Expression", color="Type",
		          xlab="",
		          ylab=paste0(gene, " expression"),
		          legend.title="Type",
		          palette = c("blue", "red"),
		          add = "jitter")+ 
	    stat_compare_means(comparisons = my_comparisons)

#���ͼƬ
pdf(file=outFile,width=5,height=4.5)
print(boxplot)
dev.off()

