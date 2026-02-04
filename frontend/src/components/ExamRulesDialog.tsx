import {
    Button,
    DialogActionTrigger,
    DialogBody,
    DialogContent,
    DialogFooter,
    DialogHeader,
    DialogRoot,
    DialogTitle,
    Text,
    VStack,
} from '@chakra-ui/react'

interface ExamRulesDialogProps {
    open: boolean
    onOpenChange: (details: { open: boolean }) => void
    onConfirm: () => void
    durationMinutes?: number
}

export const ExamRulesDialog = ({
    open,
    onOpenChange,
    onConfirm,
    durationMinutes = 30,
}: ExamRulesDialogProps) => {
    return (
        <DialogRoot open={open} onOpenChange={onOpenChange}>
            <DialogContent>
                <DialogHeader>
                    <DialogTitle>Exam Rules</DialogTitle>
                </DialogHeader>
                <DialogBody>
                    <VStack align="start" gap={2}>
                        <Text fontWeight="bold">Please read the following rules carefully:</Text>
                        <Text>1. The exam duration is {durationMinutes} minutes.</Text>
                        <Text>2. You cannot pause the exam once started.</Text>
                        <Text>3. Ensure you have a stable internet connection.</Text>
                        <Text>4. Closing the window will not submit your answers automatically.</Text>
                        <Text>5. Do not refresh the page during the exam.</Text>
                    </VStack>
                </DialogBody>
                <DialogFooter>
                    <DialogActionTrigger asChild>
                        <Button variant="outline">Cancel</Button>
                    </DialogActionTrigger>
                    <Button onClick={onConfirm}>I Understand, Start</Button>
                </DialogFooter>
            </DialogContent>
        </DialogRoot>
    )
}
